package game.data.storage.playeravatar
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestConditionDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   
   public class PlayerAvatarDescription extends PseudoResourceDescription
   {
      
      public static const ASSET_TYPE_HERO:String = "hero";
      
      public static const ASSET_TYPE_HERO_ICON:String = "hero_icon";
      
      public static const ASSET_TYPE_TITAN_ICON:String = "titan_icon";
      
      public static const ASSET_TYPE_GEAR:String = "gear";
      
      public static const ASSET_TYPE_SKILL:String = "skill";
      
      public static const ASSET_TYPE_FILE:String = "external_file";
       
      
      private var _translationMethod:String;
      
      private var _taskDescription:String;
      
      private var _unlockCondition:QuestConditionDescription;
      
      private var _assetType:String;
      
      private var _assetOwnerId:String;
      
      public function PlayerAvatarDescription(param1:Object)
      {
         super(param1);
         if(param1.unlockCondition)
         {
            _unlockCondition = new QuestConditionDescription(param1.unlockCondition);
         }
         _id = param1.id;
         _assetOwnerId = param1.assetOwnerId;
         _assetType = param1.assetType;
         _translationMethod = param1.translationMethod;
         _color = DataStorage.enum.getById_InventoryItemRarity(param1.color);
         if(!_color)
         {
            _color = DataStorage.enum.getById_InventoryItemRarity(1);
         }
         hidden = param1.hidden;
      }
      
      override public function get name() : String
      {
         return _name;
      }
      
      public function get translationMethod() : String
      {
         return _translationMethod;
      }
      
      public function get taskDescription() : String
      {
         return _taskDescription;
      }
      
      public function set taskDescription(param1:String) : void
      {
         if(_taskDescription == param1)
         {
            return;
         }
         _taskDescription = param1;
      }
      
      public function get unlockCondition() : QuestConditionDescription
      {
         return _unlockCondition;
      }
      
      public function get assetType() : String
      {
         return _assetType;
      }
      
      public function get assetOwnerId() : String
      {
         return _assetOwnerId;
      }
      
      override public function applyLocale() : void
      {
         if(Translate.has("LIB_AVATAR_NAME_" + id))
         {
            _name = Translate.translateArgs("UI_ITEMTYPE_PLAYERAVATAR",Translate.translate("LIB_AVATAR_NAME_" + id));
         }
         else
         {
            _name = "";
         }
      }
   }
}
