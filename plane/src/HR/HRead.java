package HR;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.fs.FSDataInputStream;

public class HRead {
	public List<String> CRead() {
		List<String> lists = new ArrayList<>();
		List<String> lists2 = new ArrayList<>();
		try {
			Configuration conf = new Configuration();
		    Job job = Job.getInstance();  

			conf.set("fs.defaultFS", "hdfs://localhost:9000");
		    conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem");
			FileSystem fs = FileSystem.get(conf);
			Path file = new Path("/plane/out1/part-r-00000");
			FSDataInputStream getIt = fs.open(file);
			BufferedReader d = new BufferedReader(new InputStreamReader(getIt));
			String line;
			while ((line = d.readLine()) != null) {
				String[] arr = line.split("	");
				lists.add(arr[0]+","+arr[1]);
			}
			for (int i = 0 ; i<10; i++) {
				lists2.add(lists.get(i+lists.size()-10));
			}
			d.close(); // 关闭文件
			fs.close(); // 关闭hdfs
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lists2;
	}
	public List<String> ORead() {
		List<String> lists = new ArrayList<>();
		List<String> lists2 = new ArrayList<>();
		try {
			Configuration conf = new Configuration();
			conf.set("fs.defaultFS", "hdfs://localhost:9000");
			conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem");
			FileSystem fs = FileSystem.get(conf);
			Path file = new Path("/plane/outO/part-r-00000");
			FSDataInputStream getIt = fs.open(file);
			BufferedReader d = new BufferedReader(new InputStreamReader(getIt));
			String line;
			while ((line = d.readLine()) != null) {
				String[] arr = line.split("	");
				lists.add(arr[0]+","+arr[1]);
			}
			for (int i = 0 ; i<10; i++) {
				lists2.add(lists.get(i+lists.size()-10));
			}
			d.close(); // 关闭文件
			fs.close(); // 关闭hdfs
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lists2;
	}

	public List<String> TRead() {
		List<String> lists = new ArrayList<>();
		List<String> lists2 = new ArrayList<>();
		try {
			Configuration conf = new Configuration();
			conf.set("fs.defaultFS", "hdfs://localhost:9000");
			conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem");
			FileSystem fs = FileSystem.get(conf);
			Path file = new Path("/plane/outD/part-r-00000");
			FSDataInputStream getIt = fs.open(file);
			BufferedReader d = new BufferedReader(new InputStreamReader(getIt));
			String line;
			while ((line = d.readLine()) != null) {
				String[] arr = line.split("	");
				lists.add(arr[0]+","+arr[1]);
			}
			for (int i = 0 ; i<10; i++) {
				lists2.add(lists.get(i+lists.size()-10));
			}
			d.close(); // 关闭文件
			fs.close(); // 关闭hdfs
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lists2;
	}

}