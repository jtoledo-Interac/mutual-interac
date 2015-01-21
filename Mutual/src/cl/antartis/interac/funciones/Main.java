package cl.antartis.interac.funciones;

public class Main {

	public static void main(String[] args) {
		
		
		String pathIn = "graficar.xls";
		Object[][] datos = FileUtils.excelGraficoBarras(pathIn, 16, 2);
		//request.setAttribute("datos", datos);
		for(int i=0;i<16;i++){
			System.out.println(datos[i][0]+" \t "+datos[i][1]);
		}
		
		
		
		
		
//		String path="prueba.xls";
//		FileInputStream file = null;
//		try {
//			file = new FileInputStream(new File(path));
//		} catch (FileNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		HSSFWorkbook workbook;
//		try {
//			workbook = new HSSFWorkbook(file);
//			for(int i =0; i<workbook.getNumberOfSheets();i++){
//				HSSFSheet sheet = workbook.getSheetAt(i);
//				System.out.println("------------- Sheet "+sheet.getSheetName()+" -------------");
//				Iterator<Row> rowIterator = sheet.iterator();				
//				while(rowIterator.hasNext()){
//					Row row = rowIterator.next();
//					Iterator<Cell> cells = row.iterator();
//					while(cells.hasNext()){
//						System.out.print(cells.next().toString()+"\t");
//					}
//					System.out.print("\n");
//				}
//			}
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
	}

}
