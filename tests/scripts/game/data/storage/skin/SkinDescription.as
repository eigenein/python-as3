package game.data.storage.skin
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class SkinDescription extends InventoryItemDescription
   {
       
      
      private var _heroId:int;
      
      private var _isDefault:Boolean;
      
      private var _asset:String;
      
      private var _localeKey:String;
      
      private var _levels:Vector.<SkinDescriptionLevel>;
      
      private var _eventId:int;
      
      private var _enabled:Boolean;
      
      public function SkinDescription(param1:Object)
      {
         var _loc2_:* = null;
         super(InventoryItemType.SKIN,param1);
         _heroId = param1.heroId;
         _isDefault = param1.isDefault;
         _asset = param1.asset;
         _localeKey = param1.localeKey;
         _eventId = param1.specialOffer;
         assetAtlas = param1.iconAtlas;
         assetTexture = param1.iconAsset;
         _levels = new Vector.<SkinDescriptionLevel>();
         var _loc3_:Object = param1.statData.levels;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new SkinDescriptionLevel();
            _loc2_.deserialize(_loc4_);
            _levels.push(_loc2_);
         }
         _enabled = param1.enabled;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get heroId() : int
      {
         return _heroId;
      }
      
      public function get isDefault() : Boolean
      {
         return _isDefault;
      }
      
      public function get isPremium() : Boolean
      {
         return !_isDefault;
      }
      
      public function get asset() : String
      {
         return _asset;
      }
      
      public function get localeKey() : String
      {
         return _localeKey;
      }
      
      public function get levels() : Vector.<SkinDescriptionLevel>
      {
         return _levels;
      }
      
      public function get maxLevel() : uint
      {
         return _levels.length;
      }
      
      public function get eventId() : int
      {
         return _eventId;
      }
      
      public function getUpgradeMessage(param1:uint) : String
      {
         var _loc2_:* = null;
         if(param1 > 0 && param1 <= levels.length)
         {
            _loc2_ = levels[param1 - 1].statBonus.name;
            if(param1 == 1)
            {
               return _loc2_ + " +" + levels[param1 - 1].statBonus.value;
            }
            return _loc2_ + " +" + (levels[param1 - 1].statBonus.statValue - levels[param1 - 2].statBonus.statValue);
         }
         return null;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate(_localeKey);
      }
   }
}
