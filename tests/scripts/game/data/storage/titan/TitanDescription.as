package game.data.storage.titan
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.enum.lib.TitanEvolutionStar;
   import game.data.storage.hero.HeroRoleDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.level.HeroLevel;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class TitanDescription extends UnitDescription implements ITutorialTargetKey
   {
      
      public static const MAX_STARS:uint = 6;
      
      private static const sortOrder_fireWaterEarth:Vector.<String> = new <String>["fire","water","earth"];
       
      
      private const artifacts:Vector.<TitanArtifactDescription> = new Vector.<TitanArtifactDescription>();
      
      private const starEvolution:Dictionary = new Dictionary();
      
      private var _summonCost:CostData;
      
      private var _startingStar:TitanStarEvolutionData;
      
      private var _details:TitanDetailsDescription;
      
      public var spiritArtifact:TitanArtifactDescription;
      
      private var _epicArtAsset:String;
      
      private var _role:HeroRoleDescription;
      
      public function TitanDescription(param1:Object)
      {
         super(InventoryItemType.TITAN,param1);
         _epicArtAsset = param1.epicArtAsset;
         _role = new HeroRoleDescription(param1.role,param1.roleExtended,param1.characterType);
         _obtainType = createObtainType("titan");
      }
      
      public static function sort_fireWaterEarth(param1:TitanDescription, param2:TitanDescription) : int
      {
         var _loc3_:int = sortOrder_fireWaterEarth.indexOf(param1._details.element);
         var _loc4_:int = sortOrder_fireWaterEarth.indexOf(param2._details.element);
         return (_loc3_ - _loc4_) * 1000 + (param1.id - param2.id);
      }
      
      public function get details() : TitanDetailsDescription
      {
         return _details;
      }
      
      override public function get isPlayable() : Boolean
      {
         return _details.isPlayable;
      }
      
      public function get epicArtAsset() : String
      {
         return _epicArtAsset;
      }
      
      public function getStarData(param1:TitanEvolutionStar) : TitanStarEvolutionData
      {
         return starEvolution[param1.id];
      }
      
      public function get summonCost() : CostData
      {
         return _summonCost;
      }
      
      public function get startingStar() : TitanStarEvolutionData
      {
         return _startingStar;
      }
      
      public function get role() : HeroRoleDescription
      {
         return _role;
      }
      
      function initTitanData(param1:Object) : void
      {
         var _loc2_:* = null;
         if(!_details)
         {
            _details = new TitanDetailsDescription(param1);
         }
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = param1.stars;
         for(var _loc3_ in param1.stars)
         {
            _loc2_ = new TitanStarEvolutionData(param1.stars[_loc3_].battleStatData,DataStorage.enum.getById_titanEvolutionStar(_loc3_));
            if(_loc4_)
            {
               _loc4_.next = _loc2_;
               _loc2_.prev = _loc4_;
            }
            starEvolution[_loc2_.star.id] = _loc2_;
            _loc4_ = _loc2_;
            if(!_startingStar)
            {
               _startingStar = _loc2_;
            }
         }
         if(_startingStar)
         {
            _summonCost = _startingStar.star.summonGoldCost.clone() as CostData;
            _summonCost.fragmentCollection.addItem(this,_startingStar.star.summonFragmentCost);
            _fragmentCount = _startingStar.star.summonFragmentCost;
         }
         spiritArtifact = DataStorage.titanArtifact.getById(param1.spiritArtifact) as TitanArtifactDescription;
         var _loc9_:int = 0;
         var _loc8_:* = param1.artifacts;
         for(var _loc5_ in param1.artifacts)
         {
            artifacts[_loc5_] = DataStorage.titanArtifact.getById(param1.artifacts[_loc5_]);
         }
      }
      
      public function getStatsByLevelAndStar(param1:HeroLevel, param2:TitanEvolutionStar) : BattleStats
      {
         var _loc5_:* = null;
         var _loc4_:Number = NaN;
         var _loc3_:BattleStats = _baseStats.clone();
         if(param2)
         {
            _loc5_ = getStarData(param2).statGrowthData;
            _loc4_ = Math.pow(param1.level,DataStorage.rule.titanLevelPowerCoefficient);
            _loc3_.addMultiply(_loc5_,_loc4_);
            _loc3_.round();
         }
         return _loc3_;
      }
      
      public function getArtifacts() : Vector.<TitanArtifactDescription>
      {
         return artifacts;
      }
      
      override public function applyLocale() : void
      {
         super.applyLocale();
         _name = Translate.translate("LIB_HERO_NAME_" + id);
         if(Translate.has("LIB_TITAN_DESC_" + id))
         {
            _descText = Translate.translateArgs("LIB_TITAN_DESC_" + id,_name);
         }
      }
   }
}
