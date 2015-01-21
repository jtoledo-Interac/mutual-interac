package cl.antartis.interac.beans;

import java.io.Serializable;

public class Error implements Serializable {

	private static final long serialVersionUID = 7742611997104812926L;
	private String numError = null;
	private String msjError = null;
	
	public Error(){
		this.numError = "0";
		this.msjError = "";
	}
	
	public Error(String numError, String msjError){
		this.numError = numError;
		this.msjError = msjError;
	}

	public String getNumError() {
		return numError;
	}

	public void setNumError(String numError) {
		this.numError = numError;
	}

	public String getMsjError() {
		return msjError;
	}

	public void setMsjError(String msjError) {
		this.msjError = msjError;
	}
	
	public String getError(){
		String error = "\nDATOS DE Error:";
		error += "\nnumError: "+this.numError;  
		error += "\nmsjError: "+this.msjError;
		
		return error;
	}
}