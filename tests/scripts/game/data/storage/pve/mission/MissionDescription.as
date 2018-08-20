package game.data.storage.pve.mission
{
   import com.progrestar.common.lang.Translate;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.data.cost.CostData;
   import game.data.storage.pve.PVEBattleDescription;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class MissionDescription extends PVEBattleDescription implements ITutorialTargetKey
   {
      
      private static const MAX_STAR_COUNT:int = 3;
      
      public static const TYPE_NORMAL:int = 1;
      
      public static const TYPE_HEROIC:int = 2;
      
      public static const TYPE_PARALLEL:int = 3;
       
      
      private var _isParallel:Boolean;
      
      private var _isHeroic:Boolean;
      
      private var _world:int;
      
      private var _index:int;
      
      private var _prevMissionIndex:int;
      
      private var _firstClearStartCost:CostData;
      
      private var _maxStarCount:int;
      
      private var _totalCost:CostData;
      
      private var _cost:CostData;
      
      private var _tryCost:CostData;
      
      private var _asset:int;
      
      private var _mapGuiMarker:String;
      
      public function MissionDescription(param1:Object, param2:Object)
      {
         super();
         if(param1)
         {
            _id = param1.id;
            _index = param1.index;
            _world = param1.world;
            _prevMissionIndex = param1.prevMissionIndex;
            if(param1.firstClearStartCost)
            {
               _firstClearStartCost = new CostData(param1.firstClearStartCost);
            }
            _isParallel = _prevMissionIndex;
            _mapGuiMarker = param1.mapGuiMarker;
            _isHeroic = param1.isHeroic;
            parseWaves(param2.waves);
            _tryCost = new CostData(param2.tryCost);
            _cost = new CostData(param2.cost);
            _totalCost = new CostData();
            if(param2.tryCost)
            {
               _totalCost.addRawData(param2.tryCost);
            }
            if(param2.cost)
            {
               _totalCost.addRawData(param2.cost);
            }
            if(param1.asset)
            {
               _asset = param1.asset;
            }
         }
      }
      
      public function get isParallel() : Boolean
      {
         return _isParallel;
      }
      
      public function get isHeroic() : Boolean
      {
         return _isHeroic;
      }
      
      public function get world() : int
      {
         return _world;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get prevMissionIndex() : int
      {
         return _prevMissionIndex;
      }
      
      public function get firstClearStartCost() : CostData
      {
         return _firstClearStartCost;
      }
      
      public function get maxStarCount() : int
      {
         return 3;
      }
      
      public function get totalCost() : CostData
      {
         return _totalCost;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function get tryCost() : CostData
      {
         return _tryCost;
      }
      
      public function get asset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(_asset);
      }
      
      public function get mapGuiMarker() : String
      {
         if(_mapGuiMarker)
         {
            return _mapGuiMarker;
         }
         if(asset)
         {
            return asset.mapGuiMarker;
         }
         return null;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_MISSION_NAME_" + id);
         _descText = Translate.translate("LIB_MISSION_DESC_" + id);
      }
   }
}
