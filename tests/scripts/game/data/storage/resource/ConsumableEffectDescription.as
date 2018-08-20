package game.data.storage.resource
{
   public class ConsumableEffectDescription
   {
       
      
      protected var data:Object;
      
      public function ConsumableEffectDescription(param1:Object)
      {
         super();
         this.data = param1;
      }
      
      public static function create(param1:Object) : ConsumableEffectDescription
      {
         if(param1.lootBox)
         {
            return new ConsumableEffectDescriptionLootBox(param1);
         }
         if(param1.artifactExperience)
         {
            return new ConsumableEffectDescriptionArtifactExp(param1);
         }
         return new ConsumableEffectDescription(param1);
      }
   }
}
