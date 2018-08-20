package game.data.storage.skills
{
   import com.progrestar.common.util.assert;
   
   public class SkillParameterDescription
   {
       
      
      public var name:String;
      
      public var value;
      
      public var scale:Number;
      
      public function SkillParameterDescription(param1:*)
      {
         super();
         assert(param1);
         if(param1)
         {
            name = param1.name;
            value = param1.value;
            scale = param1.scale;
         }
      }
   }
}
