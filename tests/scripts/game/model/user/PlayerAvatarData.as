package game.model.user
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerAvatarData
   {
       
      
      private var availableAvatars:Dictionary;
      
      private var _signal_updateAvatar:Signal;
      
      private var _signal_updateAvailableAvatars:Signal;
      
      private var _avatarId:int;
      
      private var _recentlyUnlockedAvatars:Dictionary;
      
      public function PlayerAvatarData()
      {
         _signal_updateAvatar = new Signal();
         _signal_updateAvailableAvatars = new Signal();
         _recentlyUnlockedAvatars = new Dictionary();
         super();
      }
      
      public function get signal_updateAvatar() : Signal
      {
         return _signal_updateAvatar;
      }
      
      public function get signal_updateAvailableAvatars() : Signal
      {
         return _signal_updateAvailableAvatars;
      }
      
      public function get avatarId() : int
      {
         return _avatarId;
      }
      
      public function get recentlyUnlockedAvatars() : Dictionary
      {
         return _recentlyUnlockedAvatars;
      }
      
      public function get avatarDesc() : PlayerAvatarDescription
      {
         return DataStorage.playerAvatar.getAvatarById(_avatarId);
      }
      
      public function isAvailable(param1:PlayerAvatarDescription) : Boolean
      {
         return availableAvatars[param1.id] == 1;
      }
      
      public function updateAvailableAvatars(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:Boolean = false;
         if(!this.availableAvatars)
         {
            this.availableAvatars = new Dictionary();
            _loc5_ = true;
         }
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1[_loc4_];
            if(!this.availableAvatars[_loc2_] && !_loc5_)
            {
               recentlyUnlockedAvatars[_loc2_] = 1;
            }
            this.availableAvatars[_loc2_] = 1;
            _loc4_++;
         }
         _signal_updateAvailableAvatars.dispatch();
      }
      
      public function initAvatarId(param1:int) : void
      {
         _avatarId = param1;
      }
      
      public function action_clearRecentlyUnlockedAvatars() : void
      {
         _recentlyUnlockedAvatars = new Dictionary();
      }
      
      public function changeAvatar(param1:int) : void
      {
         _avatarId = param1;
         _signal_updateAvatar.dispatch();
      }
   }
}
