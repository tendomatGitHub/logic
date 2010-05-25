package org.openmrs.logic.impl;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.logic.LogicCriteria;
import org.openmrs.logic.datasource.ObsDataSource;
import org.openmrs.logic.result.Result;
import org.openmrs.logic.rule.ReferenceRule;
import org.openmrs.test.BaseModuleContextSensitiveTest;
import org.openmrs.test.SkipBaseSetup;
import org.openmrs.test.TestUtil;
import org.openmrs.test.Verifies;

public class LogicServiceImplTest extends BaseModuleContextSensitiveTest {
	
	@Before
	public void prepareData() throws Exception {
		initializeInMemoryDatabase();
		executeDataSet("org/openmrs/logic/include/LogicTests-patients.xml");
		executeDataSet("org/openmrs/logic/include/LogicBasicTest.concepts.xml");
		authenticate();
	}
	
	/**
	 * @see {@link LogicServiceImpl#parse(String)}
	 */
	@Test
	@SkipBaseSetup
	@Verifies(value = "should correctly parse expression with only aggregator and token", method = "parse(String)")
	public void parseString_shouldCorrectlyParseExpressionWithOnlyAggregatorAndToken() throws Exception {
		
		ObsDataSource obsDataSource = (ObsDataSource) Context.getLogicService().getLogicDataSource("obs");
		obsDataSource.addKey("WEIGHT (KG)");
		Context.getLogicService().updateRule("WEIGHT (KG)", new ReferenceRule("obs.WEIGHT (KG)"));
		
		LogicCriteria criteria = Context.getLogicService().parse("\"WEIGHT (KG)\"");
		Result result = Context.getLogicService().eval(new Patient(3), criteria);
		Assert.assertEquals(2, result.size());
		
		LogicCriteria lastCriteria = Context.getLogicService().parse("LAST \"WEIGHT (KG)\"");
		Result lastResult = Context.getLogicService().eval(new Patient(3), lastCriteria);
		Assert.assertEquals(1, lastResult.size());
		Assert.assertEquals(70.0d, lastResult.toNumber().doubleValue(), 0);
		
		LogicCriteria firstCriteria = Context.getLogicService().parse("FIRST \"WEIGHT (KG)\"");
		Result firstResult = Context.getLogicService().eval(new Patient(3), firstCriteria);
		Assert.assertEquals(firstResult.size(), 1);
		Assert.assertEquals(60.0d, firstResult.toNumber().doubleValue(), 0);
		
	}
	
}