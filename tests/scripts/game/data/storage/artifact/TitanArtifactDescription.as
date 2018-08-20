package game.data.storage.artifact
{
   import battle.BattleStats;
   import battle.stats.ElementStats;
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   
   public class TitanArtifactDescription extends InventoryItemDescription
   {
      
      public static const MAX_STARS:uint = 6;
      
      public static const STAT_ELEMENT_ARMOR:String = "elementArmor";
      
      public static const STAT_ELEMENT_ATTACK:String = "elementAttack";
      
      public static const STAT_ELEMENT_SPIRIT_LEVEL:String = "elementSpiritLevel";
      
      public static const STAT_ELEMENT_SPIRIT_POWER:String = "elementSpiritPower";
       
      
      private var _statEffects:Vector.<ArtifactStatEffect>;
      
      private var _artifactType:String;
      
      private var _element:String;
      
      private var _artifactTypeData:ArtifactType;
      
      private var _backgroundColorIdent:String;
      
      public function TitanArtifactDescription(param1:Object, param2:Dictionary)
      {
         var _loc3_:int = 0;
         _statEffects = new Vector.<ArtifactStatEffect>();
         super(InventoryItemType.TITAN_ARTIFACT,param1);
         _name = Translate.translateArgs("LIB_TITAN_ARTIFACT_NAME_" + id);
         _artifactType = param1.type;
         _element = param1.element;
         if(_artifactType == "spirit")
         {
            _descText = Translate.translateArgs("LIB_TITAN_ARTIFACT_DESC_SPIRIT_" + id);
         }
         else if(_artifactType == "armor")
         {
            _descText = Translate.translateArgs((String("LIB_TITAN_ARTIFACT_DESC_" + _artifactType + "_" + element)).toUpperCase()) + " " + Translate.translateArgs("UI_DIALOG_TITAN_ARTIFACTS_ARMOR_DESC");
         }
         else if(_artifactType == "weapon")
         {
            _descText = Translate.translateArgs((String("LIB_TITAN_ARTIFACT_DESC_" + element)).toUpperCase()) + " " + Translate.translateArgs("UI_DIALOG_TITAN_ARTIFACTS_WEAPON_DESC");
         }
         else if(_artifactType == "amulet")
         {
            _descText = Translate.translateArgs((String("LIB_TITAN_ARTIFACT_DESC_" + _artifactType)).toUpperCase());
         }
         _backgroundColorIdent = param1.backgroundColorIdent;
         var _loc4_:Array = param1.battleEffect;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _statEffects.push(param2[_loc4_[_loc3_]]);
            _loc3_++;
         }
      }
      
      public function get artifactType() : String
      {
         return _artifactType;
      }
      
      public function get element() : String
      {
         return _element;
      }
      
      public function get artifactTypeData() : ArtifactType
      {
         return _artifactTypeData;
      }
      
      public function set artifactTypeData(param1:ArtifactType) : void
      {
         _artifactTypeData = param1;
      }
      
      public function get backgroundColorIdent() : String
      {
         return _backgroundColorIdent;
      }
      
      public function addElementStatsByStarAndLevel(param1:int, param2:int, param3:ElementStats = null) : ElementStats
      {
         var _loc5_:* = null;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param3 == null)
         {
            param3 = new ElementStats();
         }
         if(param1 > 0 && param2 > 0)
         {
            _loc5_ = _artifactTypeData.getEvolutionStarByStars(param1);
            if(_loc5_ != null)
            {
               var _loc9_:int = 0;
               var _loc8_:* = _statEffects;
               for each(var _loc4_ in _statEffects)
               {
                  _loc7_ = _loc4_.getValueByLevel(param2);
                  _loc6_ = _loc5_.battleEffectMultiplier;
                  addElementStat(param3,_loc4_.effect,_loc7_ * _loc6_);
               }
            }
            if(_artifactType == "spirit")
            {
               param3.elementSpiritLevel = param2;
            }
         }
         return param3;
      }
      
      public function addUnitStatsByStarAndLevel(param1:int, param2:int, param3:BattleStats = null) : BattleStats
      {
         var _loc5_:* = null;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param3 == null)
         {
            param3 = new BattleStats();
         }
         if(param1 > 0 && param2 > 0)
         {
            _loc5_ = _artifactTypeData.getEvolutionStarByStars(param1);
            if(_loc5_ != null)
            {
               var _loc9_:int = 0;
               var _loc8_:* = _statEffects;
               for each(var _loc4_ in _statEffects)
               {
                  _loc7_ = _loc4_.getValueByLevel(param2);
                  _loc6_ = _loc5_.battleEffectMultiplier;
                  addUnitStat(param3,_loc4_.effect,_loc7_ * _loc6_);
               }
            }
         }
         return param3;
      }
      
      public function getStatValueObjects(param1:int, param2:int, param3:Boolean) : Vector.<BattleStatValueObject>
      {
         var _loc5_:BattleStats = addUnitStatsByStarAndLevel(param1,param2);
         var _loc6_:ElementStats = addElementStatsByStarAndLevel(param1,param2);
         var _loc7_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(_loc5_);
         fixAttackStatName(_loc7_);
         var _loc4_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromElementStats(_loc6_);
         if(param3)
         {
            return _loc4_.filter(filterSpirit);
         }
         _loc4_ = _loc4_.filter(filterNotSpirit);
         return _loc7_.concat(_loc4_);
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_TITAN_ARTIFACT_NAME_" + id);
      }
      
      protected function addElementStat(param1:ElementStats, param2:String, param3:Number) : void
      {
         var _loc4_:* = param2;
         if("elementAttack" !== _loc4_)
         {
            if("elementArmor" !== _loc4_)
            {
               if("elementSpiritLevel" !== _loc4_)
               {
                  if("elementSpiritPower" === _loc4_)
                  {
                     param1.elementSpiritPower = param1.elementSpiritPower + param3;
                  }
               }
               else
               {
                  param1.elementSpiritLevel = param1.elementSpiritLevel + param3;
               }
            }
            else
            {
               param1.elementArmor = param1.elementArmor + param3;
            }
         }
         else
         {
            param1.elementAttack = param1.elementAttack + param3;
         }
      }
      
      protected function addUnitStat(param1:BattleStats, param2:String, param3:Number) : void
      {
         if(param2 != "elementAttack" && param2 != "elementArmor" && param2 != "elementSpiritPower")
         {
            param1[param2] = param1[param2] + param3;
         }
      }
      
      protected function fixAttackStatName(param1:Vector.<BattleStatValueObject>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function filterSpirit(param1:BattleStatValueObject, param2:int, param3:Vector.<BattleStatValueObject>) : Boolean
      {
         return param1.ident == "elementSpiritPower";
      }
      
      protected function filterNotSpirit(param1:BattleStatValueObject, param2:int, param3:Vector.<BattleStatValueObject>) : Boolean
      {
         return param1.ident != "elementSpiritPower";
      }
   }
}
