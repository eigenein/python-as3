package game.data.storage.hero
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.enum.lib.EvolutionStar;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.rune.RuneTierDescription;
   import game.data.storage.rune.RuneTypeDescription;
   
   public class HeroDescription extends UnitDescription
   {
      
      public static const MAX_STARS:uint = 6;
       
      
      private const colors:Dictionary = new Dictionary();
      
      private const starEvolution:Dictionary = new Dictionary();
      
      private const runes:Vector.<RuneTypeDescription> = new Vector.<RuneTypeDescription>();
      
      private const artifacts:Vector.<ArtifactDescription> = new Vector.<ArtifactDescription>();
      
      private var _summonCost:CostData;
      
      private var _startingStar:HeroStarEvolutionData;
      
      private var _startingColor:HeroColorData;
      
      private var _epicArtAsset:String;
      
      private var _role:HeroRoleDescription;
      
      private var _perks:HeroPerks;
      
      public function HeroDescription(param1:Object)
      {
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc4_:* = null;
         super(InventoryItemType.HERO,param1);
         _epicArtAsset = param1.epicArtAsset;
         _perks = new HeroPerks(param1.perk);
         var _loc6_:* = null;
         var _loc12_:int = 0;
         var _loc11_:* = param1.stars;
         for(var _loc3_ in param1.stars)
         {
            _loc2_ = new HeroStarEvolutionData(param1.stars[_loc3_].battleStatData,DataStorage.enum.getById_EvolutionStar(_loc3_));
            if(_loc6_)
            {
               _loc6_.next = _loc2_;
               _loc2_.prev = _loc6_;
            }
            starEvolution[_loc2_.star.id] = _loc2_;
            _loc6_ = _loc2_;
            if(!_startingStar)
            {
               _startingStar = _loc2_;
            }
         }
         var _loc9_:* = null;
         var _loc14_:int = 0;
         var _loc13_:* = param1.color;
         for(var _loc5_ in param1.color)
         {
            _loc10_ = DataStorage.enum.getById_HeroColor(_loc5_);
            if(_loc10_)
            {
               _loc4_ = new HeroColorData(param1.color[_loc5_],DataStorage.enum.getById_HeroColor(_loc5_));
               if(_loc9_)
               {
                  _loc9_.next = _loc4_;
                  _loc4_.prev = _loc9_;
               }
               colors[_loc4_.color.id] = _loc4_;
               _loc9_ = _loc4_;
               if(!_startingColor)
               {
                  _startingColor = _loc4_;
               }
            }
         }
         var _loc16_:int = 0;
         var _loc15_:* = param1.runes;
         for(var _loc7_ in param1.runes)
         {
            runes[_loc7_] = DataStorage.rune.getTypeById(param1.runes[_loc7_]);
         }
         var _loc18_:int = 0;
         var _loc17_:* = param1.artifacts;
         for(var _loc8_ in param1.artifacts)
         {
            artifacts[_loc8_] = DataStorage.artifact.getById(param1.artifacts[_loc8_]);
         }
         _id = param1.id;
         if(_startingStar)
         {
            _summonCost = _startingStar.star.summonGoldCost.clone() as CostData;
            _summonCost.fragmentCollection.addItem(this,_startingStar.star.summonFragmentCost);
            _fragmentCount = _startingStar.star.summonFragmentCost;
         }
         _role = new HeroRoleDescription(param1.role,param1.roleExtended,param1.characterType);
      }
      
      public function get epicArtAsset() : String
      {
         return _epicArtAsset;
      }
      
      public function get role() : HeroRoleDescription
      {
         return _role;
      }
      
      public function get summonCost() : CostData
      {
         return _summonCost;
      }
      
      public function get startingStar() : HeroStarEvolutionData
      {
         return _startingStar;
      }
      
      public function get startingColor() : HeroColorData
      {
         return _startingColor;
      }
      
      public function get perks() : HeroPerks
      {
         return _perks;
      }
      
      override public function get startingStarNum() : int
      {
         return startingStar.star.id;
      }
      
      override public function get isPlayable() : Boolean
      {
         if(obtainType && !obtainType.isObtainable)
         {
            return false;
         }
         return _unitType == "hero";
      }
      
      public function getColorData(param1:HeroColor) : HeroColorData
      {
         return colors[param1.id];
      }
      
      public function getStarData(param1:EvolutionStar) : HeroStarEvolutionData
      {
         return starEvolution[param1.id];
      }
      
      public function getRuneByTier(param1:RuneTierDescription) : RuneTypeDescription
      {
         return runes[param1.id - 1];
      }
      
      public function getRunes() : Vector.<RuneTypeDescription>
      {
         return runes;
      }
      
      public function getArtifacts() : Vector.<ArtifactDescription>
      {
         return artifacts;
      }
      
      override public function applyLocale() : void
      {
         super.applyLocale();
         _name = Translate.translate("LIB_HERO_NAME_" + id);
         if(Translate.has("LIB_HERO_DESC_" + id))
         {
            _descText = Translate.translateArgs("LIB_HERO_DESC_" + id,_name);
         }
      }
   }
}
