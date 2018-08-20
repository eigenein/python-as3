package game.view.popup.ny.sendgift
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.view.gui.components.CacheImageProxy;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.friends.referrer.ReferrerPopupListItemRendererClip;
   
   public class SelectFriendToSendNYGiftItemRendererClip extends ReferrerPopupListItemRendererClip
   {
       
      
      public var tf_id:ClipLabel;
      
      public var bg_selected:GuiClipScale9Image;
      
      public var icon_check:GuiClipImage;
      
      public function SelectFriendToSendNYGiftItemRendererClip()
      {
         tf_id = new ClipLabel();
         bg_selected = new GuiClipScale9Image();
         icon_check = new GuiClipImage();
         super();
      }
      
      override public function set data(param1:FriendDataProvider) : void
      {
         this._data = param1;
         graphics.visible = param1;
         if(param1)
         {
            tf_nickname.text = param1.player.nickname;
            tf_name.text = param1.name;
            tf_id.text = "ID: " + param1.userInfo.id;
            portrait.setFrameAndLevel(data.userInfo);
            portrait.portrait.data = null;
            if((data as FriendToSendNYGiftVO).type == 0 && data.photo)
            {
               CacheImageProxy.instance.addImage(data.photo,null,handler_avatarComplete,false);
            }
            else if((data as FriendToSendNYGiftVO).type == 1 && data.photo)
            {
               CacheImageProxy.instance.addImage(data.photo,null,handler_avatarComplete,false);
            }
            else if((data as FriendToSendNYGiftVO).type == 2)
            {
               portrait.setData(data.userInfo);
            }
         }
      }
   }
}
