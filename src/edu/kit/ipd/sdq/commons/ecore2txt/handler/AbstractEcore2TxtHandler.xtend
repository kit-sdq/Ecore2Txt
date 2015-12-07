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
import org.eclipse.core.resources.IFile
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.ui.handlers.HandlerUtil

public abstract class AbstractEcore2TxtHandler extends AbstractHandler implements IHandler {
	
	override execute(ExecutionEvent event) throws ExecutionException {
		val selection = HandlerUtil.getCurrentSelection(event)
		if (selection instanceof IStructuredSelection) {
			val structuredSelection = selection as IStructuredSelection
			val files = structuredSelection.toList.filter(typeof(IFile))
			if (files.size > 0) {
				executeEcore2TxtGenerator(files, event)
			}
			return null
		} else {
            return null
        }
	}

	override isEnabled() {
		return true;
	}
	
	def abstract void executeEcore2TxtGenerator(Iterable<IFile> files, ExecutionEvent event)
}
