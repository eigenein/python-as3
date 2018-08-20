package game.data.storage.resource
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.enum.lib.InventoryItemType;
   
   public class ConsumableDescription extends InventoryItemDescription implements IObtainableResource
   {
       
      
      public var rewardType:String;
      
      public var rewardAmount:int;
      
      private var descLocaleId:String;
      
      private var _effectDescription:ConsumableEffectDescription;
      
      private var _obtainNavigatorType:ObtainNavigatorType;
      
      public function ConsumableDescription(param1:Object)
      {
         super(InventoryItemType.CONSUMABLE,param1);
         descLocaleId = param1.descLocaleId;
         if(param1)
         {
            rewardType = param1.rewardType;
            rewardAmount = param1.rewardAmount;
            _obtainNavigatorType = new ObtainNavigatorType(param1.obtainNavigatorData);
            _effectDescription = ConsumableEffectDescription.create(param1.effectDescription);
         }
      }
      
      public function get effectDescription() : ConsumableEffectDescription
      {
         return _effectDescription;
      }
      
      public function get obtainNavigatorType() : ObtainNavigatorType
      {
         return _obtainNavigatorType;
      }
      
      override public function applyLocale() : void
      {
         var _loc1_:* = null;
         _name = Translate.translate("LIB_CONSUMABLE_NAME_" + id);
         if(effectDescription is ConsumableEffectDescriptionArtifactExp)
         {
            _loc1_ = effectDescription as ConsumableEffectDescriptionArtifactExp;
            _descText = Translate.translateArgs("LIB_CONSUMABLE_DESC_" + descLocaleId,_loc1_.minLevel,_loc1_.maxLevel);
         }
         else
         {
            _descText = Translate.translateArgs("LIB_CONSUMABLE_DESC_" + descLocaleId,rewardAmount);
         }
      }
   }
}
