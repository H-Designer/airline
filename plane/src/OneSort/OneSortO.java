package OneSort;
  
import java.io.IOException;  
import org.apache.hadoop.conf.Configuration;  
import org.apache.hadoop.fs.Path;  
import org.apache.hadoop.io.IntWritable;  
import org.apache.hadoop.io.Text;  
import org.apache.hadoop.mapreduce.Job;  
import org.apache.hadoop.mapreduce.Mapper;  
import org.apache.hadoop.mapreduce.Reducer;  
	import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;  
	import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;  
	import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;  
	import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;  
	public class OneSortO {  
	    public static class Map extends Mapper<Object , Text , IntWritable,Text >{  
    private static Text goods=new Text();  
	    private static IntWritable num=new IntWritable();  

    public void map(Object key,Text value,Context context) throws IOException, InterruptedException{  
    String line=value.toString();  
	    String arr[]=line.split("	");  
	    num.set(Integer.parseInt(arr[1]));  
	    if (arr[0].startsWith("O"))
	    {
	    	goods.set(arr[0]); 
	    	context.write(num,goods); 
	    }
    }  
	    }  
	    public static class Reduce extends Reducer< IntWritable, Text, IntWritable, Text>{  
	    private static IntWritable result= new IntWritable();  
	    public void reduce(IntWritable key,Iterable<Text> values,Context context) throws IOException, InterruptedException{  
        for(Text val:values){  
        context.write(key,val);  
        }  
        }  
	        }  
	        public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException{  
	    Configuration conf=new Configuration();  
	    Job job = Job.getInstance();  
	    job.setJarByClass(OneSortO.class);  
        job.setMapperClass(Map.class);  
        job.setReducerClass(Reduce.class);  
        job.setOutputKeyClass(IntWritable.class);  
        job.setOutputValueClass(Text.class);  
        job.setInputFormatClass(TextInputFormat.class);  
        job.setOutputFormatClass(TextOutputFormat.class);  
	    Path in=new Path("hdfs://localhost:9000/plane/out/part-r-00000");  
        Path out=new Path("hdfs://localhost:9000/plane/outO");  
        FileInputFormat.addInputPath(job,in);  
        FileOutputFormat.setOutputPath(job,out);  
    System.exit(job.waitForCompletion(true) ? 0 : 1);  
 }  
 }  
