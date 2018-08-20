package game.data.storage.artifact
{
   import game.data.ResourceListData;
   
   public class ArtifactChestDropItem extends ResourceListData
   {
       
      
      private var _level:uint;
      
      private var _multiplier:uint;
      
      public function ArtifactChestDropItem(param1:Object)
      {
         super(param1);
         if(param1)
         {
            _level = param1.level;
            _multiplier = param1.multiplier;
         }
      }
      
      public function get level() : uint
      {
         return _level;
      }
      
      public function get multiplier() : uint
      {
         return _multiplier;
      }
   }
}
