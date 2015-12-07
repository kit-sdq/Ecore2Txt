/*******************************************************************************
 * Copyright (c) 2015 Software Design and Quality (SDQ) research group
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    M. Kramer - initial API and implementation
 *******************************************************************************/
 package edu.kit.ipd.sdq.commons.ecore2txt.generator

import org.eclipse.xtext.parser.IEncodingProvider
import org.eclipse.xtext.resource.generic.AbstractGenericResourceRuntimeModule

abstract class AbstractEcore2TxtGeneratorModule extends AbstractGenericResourceRuntimeModule {

	override Class<? extends IEncodingProvider> bindIEncodingProvider() {
		return IEncodingProvider.Runtime
	}
	
}