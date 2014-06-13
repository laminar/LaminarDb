

CREATE PROCEDURE [sample].[DemoCreateAllSampleData]
AS
BEGIN
   
   SET NOCOUNT ON
   DECLARE 
      @LastActionWhen DateTime, 
      @LastActionById int,
      @SampleFileDir VARCHAR(MAX)
    
   exec sample.FillSampleTables

   SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
   SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'
   SELECT @SampleFileDir = Value FROM sample.SampleDefaults WHERE Name = 'SampleDataLocationRoot'


   -- list of Instrument symbols 
   CREATE TABLE #tempSymbols
   (
      RowId int IDENTITY(1,1),
      Symbol varchar(100) collate database_default
   )

   INSERT INTO #tempSymbols (Symbol)
   VALUES
   ('AAL.L'),('ABF.L'),('ADM.L'),('AL.L'),('AMEC.L'),('ANTO.L'),('AV.L'),('AZN.L'),('BA.L'),('BARC.L'),('BATS.L'),('BAY.L'),('BG.L'),('BGY.L'),('BLND.L'),('BLT.L'),('BP.L'),('BSY.L'),('BT-A.L'),('CBRY.L'),('CCL.L'),('CNA.L'),(
   'CNE.L'),('CPG.L'),('CPI.L'),('CPW.L'),('CW.L'),('DGE.L'),('EMG.L'),('ETI.L'),('EXPN.L'),('FGP.L'),('FP.L'),('GFS.L'),('GSK.L'),('HBOS.L'),('HMSO.L'),('HOME.L'),('HSBA.L'),('IAP.L'),('IHG.L'),('III.L'),('IMT.L'),('IPR.L'),(
   'ITV.L'),('JMAT.L'),('KAZ.L'),('KEL.L'),('KGF.L'),('LAND.L'),('LGEN.L'),('LII.L'),('LLOY.L'),('LMI.L'),('LSE.L'),('MKS.L'),('MRW.L'),('NG.L'),('NXT.L'),('OML.L'),('PRU.L'),('PSN.L'),('PSON.L'),('RB.L'),('RBS.L'),('RDSA.L'),(
   'RDSB.L'),('REL.L'),('REX.L'),('RIO.L'),('RR.L'),('RSA.L'),('RSL.L'),('RTO.L'),('RTR.L'),('SAB.L'),('SBRY.L'),('SCTN.L'),('SDR.L'),('SDRC.L'),('SGE.L'),('SHP.L'),('SL.L'),('SMIN.L'),('SN.L'),('SSE.L'),('STAN.L'),('SVT.L'),(
   'TCG.L'),('TLW.L'),('TSCO.L'),('TT.L'),('TW.L'),('ULVR.L'),('UU.L'),('VED.L'),('VOD.L'),('WOS.L'),('WPP.L'),('WTB.L'),('XTA.L'),('YELL.L')


   SET IDENTITY_INSERT dbo.SystemUser ON
   INSERT INTO dbo.SystemUser (LastActionWhen,LastActionById,UserId,Version,Code,Name) SELECT @LastActionWhen, @LastActionById,1,1,'System','System'
   SET IDENTITY_INSERT dbo.SystemUser OFF


   DECLARE @fileName VARCHAR(1000)

   SELECT @fileName = @SampleFileDir + 'Countries.csv'
   exec sample.ImportCountry @fileName, @debug=0
   --SELECT * from sample.Country

   SELECT @fileName = @SampleFileDir + 'Currencies.csv'
   exec sample.ImportCurrency @fileName, @debug=0
   --SELECT * from sample.Currency


   SELECT @fileName = @SampleFileDir + 'EODData.com\LSE.txt'
   exec sample.ImportInstrument @fileName, @CodeSuffix= '.L', @Country='GB', @Ccy = 'GBP', @Type='Stock', @debug=0
   --SELECT * from sample.Instrument
   DELETE FROM dbo.Instrument WHERE Code NOT IN (SELECT Symbol FROM #tempSymbols)

   DECLARE @RowCount int
   DECLARE @fileExists INT = 0
   SELECT @RowCount  = ISNULL(MAX(RowId),0) From #tempSymbols
   DECLARE @idx int = 1
   DECLARE @instId int, @symbol varchar(100)
   TRUNCATE table dbo.Price
   WHILE @idx <= @RowCount
   BEGIN
      SELECT @symbol = symbol, @fileName = @SampleFileDir + '\HistoricPrices\YahooFinance\' + symbol + '.csv' from #tempSymbols where RowId = @idx
      EXEC master.dbo.xp_fileexist @fileName,  @fileExists OUTPUT


      SELECT @instID = InstrumentId FROM dbo.Instrument where Code = @symbol

      IF @fileExists <> 0
      BEGIN
        exec sample.ImportYahooFinancePrice @fileName, @RowTerminator='0x0a', @Source='YF' , @InstrumentId=@InstId,  @Ccy = 'GBP', @EarliestDate='1 Jan 2012', @debug=0, @truncate =0
      END

      SELECT @idx = @idx + 1
   END
   --select count(*) from dbo.Price




   exec sample.DemoCreateBroker 
   exec sample.DemoCreateClient 
   exec sample.DemoCreateFundForClient 
   exec sample.DemoCreateContractsForFund 

   exec sample.DemoImportInterestRate
   exec sample.DemoCreateContractDetails

   update c set 
      name = ib.Name,
      code = ib.Code 
   from dbo.Client c join sample.InvestmentBanks ib on c.ClientId = ib.id

   --select * from sample.fund
   update c set 
      name = ib.Name,
      code = ib.Code + CONVERT(varchar,ib.id)
   from dbo.Fund c join sample.RandomFundNames ib on c.ClientId = ib.id

   update s set 
      name = c.Code+'-'+f.code+'-'+CONVERT(varchar,s.ContractId)+'-'+s.PayCcy+'-'+convert(varchar,s.EndDate,106)
   from dbo.Contract s
   join dbo.Fund f on f.FundId = s.FundId
   join dbo.client c on f.ClientId = c.ClientId
   

   exec sample.DemoCreateTrades
end