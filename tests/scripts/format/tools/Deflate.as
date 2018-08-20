package format.tools
{
   import haxe.io.Bytes;
   import haxe.zip.Compress;
   
   public class Deflate
   {
       
      
      public function Deflate()
      {
      }
      
      public static function run(param1:Bytes, param2:Object = undefined) : Bytes
      {
         if(param2 == null)
         {
            param2 = 9;
         }
         return Compress.run(param1,param2);
      }
   }
}
