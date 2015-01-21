package cl.antartis.interac.funciones;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

public class FileUtils {
	
	public static Object[][] excelColumnas(String pathIn,int f,int c){
		FileInputStream file = null;
		Object[][] out = new Object[f][c];
		
		try {
			file = new FileInputStream(new File(pathIn));
		} catch (FileNotFoundException e) {
			System.out.println("No se pudo abrir el archivo "+ pathIn);
			e.printStackTrace();
		}
		
		HSSFWorkbook workbook;
		
		try {
			workbook = new HSSFWorkbook(file);
			HSSFSheet sheet = workbook.getSheetAt(0);
			//Object[0][0]
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
			
			
		
		return out;
	}
}
