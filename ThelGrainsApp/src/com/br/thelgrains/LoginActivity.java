package com.br.thelgrains;

import org.json.JSONException;

import com.br.thelgrains.AsyncTask.LoginPost;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class LoginActivity extends Activity {
	private EditText cpf;
	private EditText pass;
	private Button button;
	private TextWatcher cpfMask;
	private TextView name;
	private TextView id;

// Instancia a UI e chama o método que liga a Activity à UI;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.login);
		setUserInformation();

	}
// Referencia os elementos da UI e seta os listenners
	private void setUserInformation() {
		cpf = (EditText) findViewById(R.id.txtCPF);
		pass = (EditText) findViewById(R.id.txtPass);
		button = (Button) findViewById(R.id.btnSend);
		cpfMask = CPFMask.insert("###.###.###-##", cpf);
		cpf.addTextChangedListener(cpfMask);
		button.setOnClickListener(getUserInformation);
		name = (TextView) findViewById(R.id.txtNome);
		name.setVisibility(4);
		id = (TextView) findViewById(R.id.txtId);
		id.setVisibility(4);
		id.addTextChangedListener(idWatcher);
	};
	@Override
	public void onDestroy() {
		Intent intent = new Intent(this, HomeActivity.class);
		intent.putExtra("name", name.getText().toString());
		intent.putExtra("id", id.getText().toString());
		super.onDestroy();
		startActivity(intent);
	};

/*	private void makeJSON(){
		
	};*/


	private OnClickListener getUserInformation = new OnClickListener() {
		public void onClick(View v) {
			//onDestroy();
			LoginPost post = new LoginPost(getApplicationContext(), name, id, cpf.getText().toString(),
					pass.getText().toString());
		}
	};

	private final TextWatcher idWatcher = new TextWatcher() {
		public void beforeTextChanged(CharSequence s, int start, int count, int after) {
		}

		public void onTextChanged(CharSequence s, int start, int before, int count) {
			onDestroy();
		}

		public void afterTextChanged(Editable s) {
			
		}
	};

}
