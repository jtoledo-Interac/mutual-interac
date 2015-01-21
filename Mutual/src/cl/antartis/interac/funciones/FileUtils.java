package cl.antartis.interac.funciones;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;

public class FileUtils {
	
	public static String[][] excelGraficoBarras(String pathIn, int f, int c){
		FileInputStream file = null;
		String[][] out = new String[f][c];
		try {
			file = new FileInputStream(new File(pathIn));			
		} catch (FileNotFoundException e) {
			System.out.println("No se pudo abrir el archivo "+ pathIn);
			e.printStackTrace();
			return null;
		}
		
		HSSFWorkbook workbook;
		
		try {
			workbook = new HSSFWorkbook(file);
			HSSFSheet sheet = workbook.getSheetAt(0);
			for(int i =0;i<f;i++){
				Row row =sheet.getRow(i); 
				for(int j=0;j<c;j++){
					out[i][j]=row.getCell(j).toString();
				}
			}
			workbook.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		return out;
	}
	
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
