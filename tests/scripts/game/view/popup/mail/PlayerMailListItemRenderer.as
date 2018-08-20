package game.view.popup.mail
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.mediator.gui.popup.mail.PlayerMailEntryValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMailListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:PlayerMailRendererClip;
      
      private var _signal_select:Signal;
      
      public function PlayerMailListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerMailEntryValueObject);
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override protected function commitData() : void
      {
         var _loc2_:* = null;
         super.commitData();
         var _loc1_:PlayerMailEntryValueObject = data as PlayerMailEntryValueObject;
         if(_loc1_)
         {
            clip.tf_subject.text = _loc1_.title;
            clip.tf_from.text = _loc1_.userName;
            clip.tf_date.text = _loc1_.date;
            _loc2_ = _loc1_.avatar;
            if(_loc1_.playerFriend && _loc1_.playerFriend.photoURL)
            {
               clip.avatar.socialAvatarData = _loc1_.playerFriend;
            }
            else
            {
               clip.avatar.data = _loc2_;
            }
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerMailEntryValueObject = data as PlayerMailEntryValueObject;
         if(!_loc2_)
         {
         }
         .super.data = param1;
         _loc2_ = data as PlayerMailEntryValueObject;
         if(!_loc2_)
         {
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_renderer_mail();
         addChild(clip.graphics);
         clip.button_read.signal_click.add(buttonClickInfo);
      }
      
      private function buttonClick() : void
      {
      }
      
      private function buttonClickInfo() : void
      {
         _signal_select.dispatch(data as PlayerMailEntryValueObject);
      }
   }
}
