package edu.kit.ipd.sdq.commons.ecore2txt.generator;

import org.eclipse.xtext.parser.IEncodingProvider;
import org.eclipse.xtext.resource.generic.AbstractGenericResourceRuntimeModule;

@SuppressWarnings("all")
public abstract class AbstractEcore2TxtGeneratorModule extends AbstractGenericResourceRuntimeModule {
  @Override
  public Class<? extends IEncodingProvider> bindIEncodingProvider() {
    return IEncodingProvider.Runtime.class;
  }
}
