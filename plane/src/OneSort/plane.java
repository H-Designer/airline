package OneSort;

import java.io.IOException;  
import org.apache.hadoop.conf.Configuration;  
import org.apache.hadoop.fs.Path;  
import org.apache.hadoop.io.IntWritable;  
import org.apache.hadoop.io.NullWritable;  
import org.apache.hadoop.io.Text;  
import org.apache.hadoop.mapreduce.Job;  
import org.apache.hadoop.mapreduce.Mapper;  
import org.apache.hadoop.mapreduce.Reducer;  
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;  
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;  
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;  
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;  
//求票数和
public class plane{  
	    public static class Map extends Mapper<Object , Text , Text , IntWritable>{  
	    private static Text newKey=new Text();  
	    public void map(Object key,Text value,Context context) throws IOException, InterruptedException{  
	    String line=value.toString();  
	    String arr[]=line.split(","); 
	  
	    newKey.set(arr[1]); 
	    int click=Integer.parseInt(arr[3]);  
	    context.write(newKey, new IntWritable(click)); 
	   
	   
	    newKey.set(arr[2]); 
	    int click1=Integer.parseInt(arr[3]);  
	    context.write(newKey, new IntWritable(click1)); 
	    
	     
	    }  
	    }  
	    public static class Reduce extends Reducer<Text, IntWritable, Text, IntWritable>{  
	    public void reduce(Text key,Iterable<IntWritable> values,Context context) throws IOException, InterruptedException{  

	    	int num=0;  
	        int count=0;  
	        for(IntWritable val:values){  
        num+=val.get();  
	        count++;  
	        }  
	        context.write(key,new IntWritable(count));  
	        }  
	        }  
 public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException{  
	    Configuration conf=new Configuration(); 
	    System.out.println("start");  
	    Job job = Job.getInstance();  
        job.setJarByClass(plane.class);  
	    job.setMapperClass(Map.class);  
	    job.setReducerClass(Reduce.class);  
	    job.setOutputKeyClass(Text.class);  
        job.setOutputValueClass(IntWritable.class);  
	    job.setInputFormatClass(TextInputFormat.class);  
        job.setOutputFormatClass(TextOutputFormat.class);  
        Path in=new Path("hdfs://localhost:9000/plane/in/region");  
	    Path out=new Path("hdfs://localhost:9000/plane/out");  
        FileInputFormat.addInputPath(job,in);  
	        FileOutputFormat.setOutputPath(job,out);  
	        System.exit(job.waitForCompletion(true) ? 0 : 1);  
	        }  
        }  
