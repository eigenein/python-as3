package game.data.storage.artifact
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   
   public class ArtifactDescription extends InventoryItemDescription
   {
      
      public static const MAX_STARS:uint = 6;
      
      public static const BACKGROUND_COLOR_PURPLE:String = "purple";
      
      public static const BACKGROUND_COLOR_GOLD:String = "gold";
      
      public static const BACKGROUND_COLOR_YELOW:String = "yellow";
      
      public static const BACKGROUND_COLOR_RED:String = "red";
      
      public static const BACKGROUND_COLOR_BLUE:String = "blue";
      
      public static const BACKGROUND_COLOR_GREEN:String = "green";
      
      public static const BACKGROUND_COLOR_CYAN:String = "cyan";
       
      
      private var _artifactType:String;
      
      private var _artifactTypeData:ArtifactType;
      
      private var _effectDuration:Number;
      
      private var _backgroundColorIdent:String;
      
      private var _battleEffects:Array;
      
      private var _battleEffectsData:Vector.<ArtifactBattleEffect>;
      
      public function ArtifactDescription(param1:Object)
      {
         super(InventoryItemType.ARTIFACT,param1);
         _name = Translate.translateArgs("LIB_ARTIFACT_NAME_" + id);
         _artifactType = param1.type;
         _battleEffects = param1.battleEffect;
         _effectDuration = param1.effectDuration;
         _backgroundColorIdent = param1.backgroundColorIdent;
         _battleEffectsData = new Vector.<ArtifactBattleEffect>();
      }
      
      public function get artifactType() : String
      {
         return _artifactType;
      }
      
      public function get artifactTypeData() : ArtifactType
      {
         return _artifactTypeData;
      }
      
      public function set artifactTypeData(param1:ArtifactType) : void
      {
         _artifactTypeData = param1;
      }
      
      public function get effectDuration() : Number
      {
         return _effectDuration;
      }
      
      public function get backgroundColorIdent() : String
      {
         return _backgroundColorIdent;
      }
      
      public function get battleEffects() : Array
      {
         return _battleEffects;
      }
      
      public function get battleEffectsData() : Vector.<ArtifactBattleEffect>
      {
         return _battleEffectsData;
      }
      
      public function addStatsByStarAndLevel(param1:int, param2:int, param3:BattleStats = null) : BattleStats
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_ARTIFACT_NAME_" + id);
      }
      
      public function getStatValueObjects(param1:int, param2:int) : Vector.<BattleStatValueObject>
      {
         var _loc4_:* = null;
         var _loc3_:BattleStats = addStatsByStarAndLevel(param1,param2);
         var _loc5_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(_loc3_);
         if(_artifactType == "weapon")
         {
            if(param1 > 0 && param2 > 0)
            {
               _loc4_ = _artifactTypeData.getEvolutionStarByStars(param1);
               _loc5_.unshift(new BattleStatValueObject("applyChance",_loc4_.applyChancePercent,true,true));
            }
         }
         return _loc5_;
      }
   }
}
