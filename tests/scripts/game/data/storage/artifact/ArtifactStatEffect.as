package game.data.storage.artifact
{
   public class ArtifactStatEffect
   {
       
      
      private var _id:uint;
      
      private var _effect:String;
      
      private var _levels:Vector.<Number>;
      
      public function ArtifactStatEffect(param1:Object)
      {
         _levels = new Vector.<Number>();
         super();
         deserialize(param1);
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get effect() : String
      {
         return _effect;
      }
      
      public function getValueByLevel(param1:int) : Number
      {
         if(param1 > 0 && param1 < _levels.length)
         {
            return _levels[param1];
         }
         return 0;
      }
      
      protected function deserialize(param1:Object) : void
      {
         _id = param1.id;
         _effect = param1.effect;
         if(param1.levels)
         {
            _levels = Vector.<Number>(param1.levels);
         }
         else
         {
            _levels = new Vector.<Number>();
         }
      }
   }
}
