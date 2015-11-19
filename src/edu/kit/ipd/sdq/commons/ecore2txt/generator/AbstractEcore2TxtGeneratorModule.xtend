package edu.kit.ipd.sdq.commons.ecore2txt.generator

import org.eclipse.xtext.parser.IEncodingProvider
import org.eclipse.xtext.resource.generic.AbstractGenericResourceRuntimeModule

abstract class AbstractEcore2TxtGeneratorModule extends AbstractGenericResourceRuntimeModule {

	override Class<? extends IEncodingProvider> bindIEncodingProvider() {
		return IEncodingProvider.Runtime
	}
	
}