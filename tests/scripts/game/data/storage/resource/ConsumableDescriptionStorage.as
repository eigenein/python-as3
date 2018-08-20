package game.data.storage.resource
{
   import game.data.storage.DescriptionStorage;
   
   public class ConsumableDescriptionStorage extends DescriptionStorage
   {
      
      public static const REWARD_TYPE_HERO_EXP:String = "heroExperience";
      
      public static const REWARD_TYPE_TITAN_EXP:String = "titanExperience";
      
      public static const REWARD_TYPE_TITAN_GIFT:String = "titanGift";
      
      public static const REWARD_TYPE_ENCHANT_VALUE:String = "enchantValue";
      
      public static const REWARD_TYPE_GOLD:String = "gold";
      
      public static const REWARD_TYPE_TRANSFER:String = "transfer";
      
      public static const REWARD_TYPE_LOOT_BOX:String = "lootBox";
      
      public static const REWARD_TYPE_STAMINA:String = "stamina";
      
      public static const REWARD_ARTIFACT_CHEST_KEY:String = "artifactChestKey";
      
      public static const REWARD_TITAM_ARTIFACT_CHEST_KEY:String = "titanArtifactChestKey";
      
      public static const REWARD_ARTIFACT_EVOLUTION:String = "artifactEvolution";
      
      public static const REWARD_ARTIFACT_EXPERIENCE:String = "artifactExperience";
       
      
      public function ConsumableDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:ConsumableDescription = new ConsumableDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      public function getItemsByType(param1:String) : Vector.<ConsumableDescription>
      {
         var _loc3_:Vector.<ConsumableDescription> = new Vector.<ConsumableDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.rewardType == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getTitanSparkDesc() : ConsumableDescription
      {
         var _loc1_:Vector.<ConsumableDescription> = getItemsByType("titanGift");
         return _loc1_[0];
      }
      
      public function getArtifactChestKeyDesc() : ConsumableDescription
      {
         var _loc1_:Vector.<ConsumableDescription> = getItemsByType("artifactChestKey");
         return _loc1_[0];
      }
      
      public function getTitanArtifactChestKeyDesc() : ConsumableDescription
      {
         var _loc1_:Vector.<ConsumableDescription> = getItemsByType("titanArtifactChestKey");
         return _loc1_[0];
      }
   }
}
