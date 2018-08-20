package game.data.storage.hero
{
   import battle.HeroStats;
   import battle.data.MainStat;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.resource.InventoryItemObtainType;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class UnitDescription extends InventoryItemDescription implements ITutorialTargetKey
   {
      
      public static const UNIT_TYPE_HERO:String = "hero";
      
      public static const UNIT_TYPE_CREEP:String = "creep";
      
      public static const UNIT_TYPE_BOSS:String = "boss";
      
      public static const UNIT_TYPE_TITAN:String = "titan";
       
      
      protected var _baseStats:HeroStats;
      
      protected var _mainStat:MainStat;
      
      protected var _battleOrder:int;
      
      protected var _scale:Number;
      
      protected var _asset:String;
      
      protected var _unitType:String;
      
      public function UnitDescription(param1:InventoryItemType, param2:Object)
      {
         super(param1,param2);
         _unitType = param2.type;
         _asset = param2.asset;
         _baseStats = HeroStats.fromRawData(param2.baseStats);
         _mainStat = MainStat.fromString(param2.mainStat);
         _battleOrder = param2.battleOrder;
         _scale = param2.scale;
         assetAtlas = param2.iconAssetAtlas;
         assetTexture = param2.iconAssetTexture;
         _iconAssetTexture = null;
      }
      
      public function get baseStats() : HeroStats
      {
         return _baseStats;
      }
      
      public function get mainStat() : MainStat
      {
         return _mainStat;
      }
      
      public function get battleOrder() : int
      {
         return _battleOrder;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function get asset() : String
      {
         return _asset;
      }
      
      public function get unitType() : String
      {
         return _unitType;
      }
      
      public function get battleOrderIndex() : int
      {
         if(_battleOrder < 1000)
         {
            return 1;
         }
         if(_battleOrder < 2000)
         {
            return 2;
         }
         return 3;
      }
      
      public function get isPlayable() : Boolean
      {
         return false;
      }
      
      public function get startingStarNum() : int
      {
         return 0;
      }
      
      override public function createObtainType(param1:String) : InventoryItemObtainType
      {
         return HeroObtainType.getObject(param1);
      }
   }
}
