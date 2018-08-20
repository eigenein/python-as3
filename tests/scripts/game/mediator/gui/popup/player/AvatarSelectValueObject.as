package game.mediator.gui.popup.player
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import idv.cjcat.signals.Signal;
   import starling.textures.Texture;
   
   public class AvatarSelectValueObject
   {
       
      
      private var _selected:Boolean;
      
      private var _available:Boolean;
      
      private var _justUnlocked:Boolean;
      
      private var _desc:PlayerAvatarDescription;
      
      private var _signal_availableStateChange:Signal;
      
      public function AvatarSelectValueObject(param1:PlayerAvatarDescription, param2:Boolean, param3:Boolean)
      {
         _signal_availableStateChange = new Signal(AvatarSelectValueObject);
         super();
         this._selected = param3;
         this._available = param2;
         this._desc = param1;
      }
      
      public function get taskDescription() : String
      {
         if(!available)
         {
            return Translate.translateArgs("UI_POPUP_PLAYER_AVATAR_CONTIDION",desc.taskDescription);
         }
         var _loc1_:String = "";
         if(desc.name)
         {
            _loc1_ = _loc1_ + (desc.name + "\n");
         }
         _loc1_ = _loc1_ + Translate.translate("UI_POPUP_PLAYER_AVATAR_UNLOCKED");
         return _loc1_;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get available() : Boolean
      {
         return _available;
      }
      
      public function get justUnlocked() : Boolean
      {
         return _justUnlocked;
      }
      
      public function get desc() : PlayerAvatarDescription
      {
         return _desc;
      }
      
      public function get avatarBackgroundTexture() : Texture
      {
         return DataStorage.playerAvatar.getTextureBackground(desc);
      }
      
      public function get avatarTexture() : Texture
      {
         return DataStorage.playerAvatar.getTexture(desc);
      }
      
      public function get signal_availableStateChange() : Signal
      {
         return _signal_availableStateChange;
      }
      
      public function unlock() : void
      {
         _available = true;
         _justUnlocked = true;
         _signal_availableStateChange.dispatch(this);
      }
   }
}
