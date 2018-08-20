package game.data.storage.resource
{
   public class ConsumableEffectDescriptionArtifactExp extends ConsumableEffectDescription
   {
       
      
      private var _minLevel:int;
      
      private var _maxLevel:int;
      
      public function ConsumableEffectDescriptionArtifactExp(param1:Object)
      {
         super(param1);
         if(param1.levelRange)
         {
            _minLevel = param1.levelRange.min;
            _maxLevel = param1.levelRange.max;
         }
      }
      
      public function get minLevel() : int
      {
         return _minLevel;
      }
      
      public function get maxLevel() : int
      {
         return _maxLevel;
      }
   }
}
