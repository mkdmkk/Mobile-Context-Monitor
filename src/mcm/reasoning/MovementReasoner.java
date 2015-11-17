package mcm.reasoning;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import mcm.dao.ContextDAO;

import org.python.util.PythonInterpreter;

public class MovementReasoner {
	private PythonInterpreter interp = null;
	private ContextDAO contextDAO = null; 

	public MovementReasoner() {
		// TODO Auto-generated constructor stub
		interp = new PythonInterpreter();
		contextDAO = new ContextDAO();
	}

	public void clearTraningDataFile() {
		interp.exec("import os");
		interp.exec("f1 = open('movement_state_ax.rdat', 'w'");
		interp.exec("f2 = open('movement_state_ay.rdat', 'w'");
		interp.exec("f3 = open('movement_state_az.rdat', 'w'");
		interp.exec("f1.close()");
		interp.exec("f2.close()");
		interp.exec("f3.close()");
	}

	public void writeTrainingDataFile(int state, long sTime, long eTime, boolean isAppend) {
		int size = 50; // Temp. code
		List<List<Double>> data = contextDAO.getContextsWithPeriod(1, new Timestamp(sTime), new Timestamp(eTime));
		interp.exec("import os");
		if(isAppend) {
			interp.exec("movement_state_ax = open('movement_state_ax.rdat', 'a')");
			interp.exec("movement_state_ay = open('movement_state_ay.rdat', 'a')");
			interp.exec("movement_state_az = open('movement_state_az.rdat', 'a')");
		}
		interp.exec("movement_state_ax = open('movement_state_ax.rdat', 'w')");
		interp.exec("movement_state_ay = open('movement_state_ay.rdat', 'w')");
		interp.exec("movement_state_az = open('movement_state_az.rdat', 'w')");
		for(int i = 0; i < data.get(0).size()/size; i++) {
			for(int j = 0; j < size; j++) {
				interp.exec("movement_state_ax.write('"+data.get(0).get(i*size+j)+" ')");
			}
			interp.exec("movement_state_ax.write('"+state+"\\n')");
		}
		for(int i = 0; i < data.get(1).size()/size; i++) {
			for(int j = 0; j < size; j++) {
				interp.exec("movement_state_ay.write('"+data.get(1).get(i*size+j)+" ')");
			}
			interp.exec("movement_state_ay.write('"+state+"\\n')");
		}
		for(int i = 0; i < data.get(2).size()/size; i++) {
			for(int j = 0; j < size; j++) {
				interp.exec("movement_state_az.write('"+data.get(2).get(i*size+j)+" ')");
			}
			interp.exec("movement_state_az.write('"+state+"\\n')");
		}
		interp.exec("movement_state_ax.close()");
		interp.exec("movement_state_ay.close()");
		interp.exec("movement_state_az.close()");
	}

	public String getMovementStateKNN(long sTime, long eTime, int k) {
		int size = 10; // Temp. code 
		interp.exec("from pattern_recognition.movement_reasoner import KDTree");
		interp.exec("import os");
		interp.exec("movement_state_ax = open('/Users/mkk/Workspace/MobileContextMonitor/movement_state_ax.rdat')");
		interp.exec("movement_state_ay = open('/Users/mkk/Workspace/MobileContextMonitor/movement_state_ay.rdat')");
		interp.exec("movement_state_az = open('/Users/mkk/Workspace/MobileContextMonitor/movement_state_az.rdat')");
		interp.exec("training_ax = []");
		interp.exec("training_ay = []");
		interp.exec("training_az = []");
		interp.exec("" +
				"for line in movement_state_ax.readlines():\n" +
				"	tmp = []\n" +
				"	for data in line.split():\n" +
				"		tmp.append(float(data))\n" +
				"	training_ax.append(tmp)" +
				"");
		interp.exec("" +
				"for line in movement_state_ay.readlines():\n" +
				"	tmp = []\n" +
				"	for data in line.split():\n" +
				"		tmp.append(float(data))\n" +
				"	training_ay.append(tmp)" +
				"");
		interp.exec("" +
				"for line in movement_state_az.readlines():\n" +
				"	tmp = []\n" +
				"	for data in line.split():\n" +
				"		tmp.append(float(data))\n" +
				"	training_az.append(tmp)" +
				"");
		interp.exec("movement_state_ax.close()");
		interp.exec("movement_state_ay.close()");
		interp.exec("movement_state_az.close()");

		List<List<Double>> data = contextDAO.getNContextsWithPeriod(1, new Timestamp(sTime), new Timestamp(eTime), size);
		if(data.get(0).size() < size) {
			return null;
		}
		interp.exec("testing_ax = []");
		interp.exec("testing_ay = []");
		interp.exec("testing_az = []");
		for(Double d:data.get(0)) {
			interp.exec("testing_ax.append("+d+")");
		}
		for(Double d:data.get(1)) {
			interp.exec("testing_ay.append("+d+")");
		}
		for(Double d:data.get(2)) {
			interp.exec("testing_az.append("+d+")");
		}
		//		interp.exec("print training_ax");
		//		interp.exec("print training_ay");
		//		interp.exec("print training_az");
		//		interp.exec("print testing_ax");
		//		interp.exec("print testing_ay");
		//		interp.exec("print testing_az");
		interp.exec("tree_ax = KDTree.construct_from_data(training_ax)");
		interp.exec("tree_ay = KDTree.construct_from_data(training_ay)");
		interp.exec("tree_az = KDTree.construct_from_data(training_az)");
		interp.exec("nearest_ax = tree_ax.query(testing_ax, t="+k+")");
		interp.exec("nearest_ay = tree_ay.query(testing_ay, t="+k+")");
		interp.exec("nearest_az = tree_az.query(testing_az, t="+k+")");
		interp.exec("print nearest_ax");
		interp.exec("print nearest_ay");
		interp.exec("print nearest_az");

		interp.exec("knn = []");
		interp.exec("" +
				"for i in range("+k+"):\n" +
				"	knn.append(0)");
		interp.exec("" +
				"for i in range("+k+"):\n" +
				"	knn[int(nearest_ax[i]-1)]=knn[int(nearest_ax[i]-1)]+1\n" +
				"	knn[int(nearest_ax[i]-1)]=knn[int(nearest_ay[i]-1)]+1\n" +
				"	knn[int(nearest_ax[i]-1)]=knn[int(nearest_az[i]-1)]+1" +
				"");
		
		
		return interp.get("knn").toString();
	}

	public static void main(String[] args) {
		MovementReasoner mr = new MovementReasoner();
		mr.getMovementStateKNN(System.currentTimeMillis()-10000, System.currentTimeMillis(), 5);
		//		mr.writeTrainingDataFile(10, 1, System.currentTimeMillis()-10000000, System.currentTimeMillis(), false);
	}
}

