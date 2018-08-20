package format.tools
{
   import haxe.io.Bytes;
   import haxe.zip.Uncompress;
   
   public class Inflate
   {
       
      
      public function Inflate()
      {
      }
      
      public static function run(param1:Bytes) : Bytes
      {
         return Uncompress.run(param1);
      }
   }
}
