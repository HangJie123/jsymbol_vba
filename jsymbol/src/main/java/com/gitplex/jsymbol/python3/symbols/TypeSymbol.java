package com.gitplex.jsymbol.python3.symbols;

import org.apache.wicket.Component;
import org.apache.wicket.behavior.AttributeAppender;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.request.resource.PackageResourceReference;

import com.gitplex.jsymbol.Range;
import com.gitplex.jsymbol.TokenPosition;
import com.gitplex.jsymbol.python3.symbols.ui.icon.IconLocator;
import com.gitplex.jsymbol.util.NoAntiCacheImage;

public class TypeSymbol extends Python3Symbol{

	private static final long serialVersionUID = 1L;

	public TypeSymbol(Python3Symbol parent, String name, TokenPosition position, TokenPosition scope) {
		super(parent, name, position, scope);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean isPrimary() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public Image renderIcon(String componentId) {
		Image icon;
		icon = new NoAntiCacheImage(componentId, new PackageResourceReference(IconLocator.class, "class_obj.png"));
		icon.add(AttributeAppender.append("title", "public class"));
		return icon;
	}

	@Override
	public Component render(String componentId, Range highlight) {
		return new Label(componentId, getName());
	}

}
