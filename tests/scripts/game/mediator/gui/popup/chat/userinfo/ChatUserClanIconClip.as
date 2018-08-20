package game.mediator.gui.popup.chat.userinfo
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.view.gui.components.ClipButton;
   import game.view.popup.clan.editicon.ClanIconClip;
   
   public class ChatUserClanIconClip extends ClipButton
   {
       
      
      private var empty:ClipSprite;
      
      private var icon:ClanIconClip;
      
      public function ChatUserClanIconClip()
      {
         super();
      }
      
      public function setupEmpty() : void
      {
         graphics.touchable = false;
         empty = AssetStorage.rsx.clan_icons.createEmptyClip();
         container.addChild(empty.graphics);
      }
      
      public function setupFlag(param1:ClanIconValueObject) : void
      {
         container.removeChildren();
         icon = AssetStorage.rsx.clan_icons.createFlagClip();
         AssetStorage.rsx.clan_icons.setupFlag(icon,param1);
         var _loc2_:* = 0.45;
         icon.graphics.scaleY = _loc2_;
         icon.graphics.scaleX = _loc2_;
         container.addChild(icon.graphics);
         graphics.touchable = true;
      }
   }
}
