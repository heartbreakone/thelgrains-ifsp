package com.br.thelgrains;

import org.json.JSONException;
import org.json.JSONObject;
import com.br.thelgrains.AsyncTask.*;
import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class HomeActivity extends Activity {
private TextView txt;
private Bundle bundle;
private String name;
private String id;

	
@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home);
		setUserInformation(savedInstanceState);
		
		
	}

public void setUserInformation(Bundle bundle){
	txt = (TextView) findViewById(R.id.txtId);
	bundle = getIntent().getExtras();
	name = bundle.getString("name");
	id = bundle.getString("id");
	txt.setText("EVA HAIR FASHION\nFuncionário(a):\n"+name);
	
	//String rs = "{\"array\":[{\"id\":911663686,\"servico\":\"Limpeza de Pele\",\"created_at\":\"2015-08-31T15:39:48.141Z\"},{\"id\":911663687,\"servico\":\"tintura\",\"created_at\":\"2015-08-31T17:45:04.500Z\"},{\"id\":911663688,\"servico\":\"Limpeza de Pele\",\"created_at\":\"2015-08-31T17:45:45.942Z\"}]}";
	
	
	
}


}

