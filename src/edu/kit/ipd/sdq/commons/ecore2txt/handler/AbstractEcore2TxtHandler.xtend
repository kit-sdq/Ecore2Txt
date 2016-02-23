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
 package edu.kit.ipd.sdq.commons.ecore2txt.handler;

import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.commands.ExecutionException
import org.eclipse.core.commands.IHandler
import org.eclipse.core.resources.IResource
import org.eclipse.jface.viewers.ISelection
import org.eclipse.ui.handlers.HandlerUtil

public abstract class AbstractEcore2TxtHandler<T extends IResource> extends AbstractHandler implements IHandler {
	
	override execute(ExecutionEvent event) throws ExecutionException {
		val selection = HandlerUtil.getCurrentSelection(event)
		val filteredSelection = filterSelection(selection)
		executeEcore2TxtGenerator(filteredSelection, event, getPlugInID())
		return null
	}

	override isEnabled() {
		return true;
	}
	
	def abstract Iterable<T> filterSelection(ISelection selection) 
	
	def abstract String getPlugInID()
	
	def abstract void executeEcore2TxtGenerator(Iterable<T> filteredSelection, ExecutionEvent event, String plugInID) throws ExecutionException
}
