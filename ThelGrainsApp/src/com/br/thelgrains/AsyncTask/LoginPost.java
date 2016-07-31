package com.br.thelgrains.AsyncTask;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.protocol.HTTP;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.os.AsyncTask;
import android.widget.TextView;
import android.widget.Toast;

public class LoginPost extends AsyncTask<String, Void, String> {

	private TextView name;
	private TextView id;
	private String CPF;
	private String Pass;
	private Context ctl;


	public LoginPost(Context ctl, TextView name, TextView id, String CPF, String Pass) {
	
		this.CPF = CPF;
		this.Pass = Pass;
		this.id = id;
		this.name = name;
		this.ctl = ctl;
		execute(CPF, Pass);
	};

	@Override
	protected String doInBackground(String... params) {

		String CPF = params[0];
		String Pass = params[1];

		HttpClient httpClient = new DefaultHttpClient();
		HttpPost httpPost = new HttpPost("https://thelgrains.herokuapp.com/api/login.json");
		JSONObject header = new JSONObject();
		JSONObject jsonobj = new JSONObject();

		try {
			header.put("password", Pass);
			header.put("cpf", CPF);
			jsonobj.put("api_user", header);
			StringEntity se = new StringEntity(jsonobj.toString());
			System.out.println(jsonobj.toString());
			se.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE, "application/json;charset=UTF-8"));
			httpPost.setEntity(se);

			try {

				HttpResponse httpResponse = httpClient.execute(httpPost);
				InputStream inputStream = httpResponse.getEntity().getContent();
				InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
				BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
				StringBuilder stringBuilder = new StringBuilder();
				String bufferedStrChunk = null;

				while ((bufferedStrChunk = bufferedReader.readLine()) != null) {
					stringBuilder.append(bufferedStrChunk);
				}

				return stringBuilder.toString();

			} catch (ClientProtocolException cpe) {
				cpe.printStackTrace();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}

		} catch (UnsupportedEncodingException uee) {
			uee.printStackTrace();
		} catch (JSONException jse) {
			jse.printStackTrace();
		}

		return null;
	}

	@Override
	protected void onPostExecute(String result) {
		super.onPostExecute(result);
		try {
			JSONObject status = (JSONObject) new JSONObject(result).get("status");

			if (!status.getBoolean("success"))
				Toast.makeText(ctl, status.get("alert").toString(), Toast.LENGTH_SHORT).show();
			else {
				JSONObject user = (JSONObject) new JSONObject(result).get("user");
				Toast.makeText(ctl, status.get("notice").toString(), Toast.LENGTH_SHORT).show();
				name.setText(user.getString("nome".toString()));
				id.setText(""+user.getInt("id"));
			}

		} catch (JSONException JSONe) {
			JSONe.printStackTrace();}
	
	}

}