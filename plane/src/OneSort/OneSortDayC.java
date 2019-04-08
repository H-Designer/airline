package OneSort;

/**
 * 统计数量
 */
import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.Mapper.Context;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
public class OneSortDayC {

	public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException {
		// TODO Auto-generated method stub
		Job job = Job.getInstance();
		job.setJobName("WordCount");
		job.setJarByClass(OneSortDayC.class);
		job.setMapperClass(doMapper.class);
		job.setReducerClass(doReducer.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		Path in = new Path("hdfs://localhost:9000/plane/in");
		Path out = new Path("hdfs://localhost:9000/plane/outD");
		FileInputFormat.addInputPath(job, in);
		FileOutputFormat.setOutputPath(job, out);
		System.exit(job.waitForCompletion(true)?0:1);
	}
	
	
	public static class doMapper extends Mapper<Object, Text, Text, IntWritable> {

		public static final IntWritable one = new IntWritable(1);
		public static Text word = new Text();
		@Override
		protected void map(Object key,Text value,Context context)throws IOException,InterruptedException{
				String line = value.toString();
				String arr[] = line.split(",");
				word.set(arr[0]);
				one.set(Integer.parseInt(arr[3]));
				context.write(word, one);	
		}
		
	}
	
	public static class doReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
		private IntWritable result = new IntWritable();
		@Override
		protected void reduce(Text key,Iterable<IntWritable> values,Context context)throws IOException,InterruptedException {
			int sum = 0;
			for(IntWritable value:values) {
				sum+=value.get();
			}
			result.set(sum);
			context.write(key, result);
		}

	}
}
