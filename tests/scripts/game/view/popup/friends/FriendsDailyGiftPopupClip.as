package game.view.popup.friends
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class FriendsDailyGiftPopupClip extends PopupClipBase
   {
       
      
      public var button_invite:ClipButtonLabeled;
      
      public var button_send_gifts:FriendsDailyGiftSendButton;
      
      public var button_shop:ClipButtonLabeled;
      
      public var button_invite_alt:ClipButtonLabeled;
      
      public var layout_bottom_btns:ClipLayout;
      
      public var tf_caption:ClipLabel;
      
      public var tf_caption_2:ClipLabel;
      
      public var tf_no_friends:ClipLabel;
      
      public var panel_1:FriendRendererClip;
      
      public var panel_2:FriendRendererClip;
      
      public var panel_3:FriendRendererClip;
      
      public var panel_4:FriendRendererClip;
      
      public var panel_5:FriendRendererClip;
      
      public var panel_6:FriendRendererClip;
      
      public var panels:Vector.<FriendRendererClip>;
      
      public var LinePale_148_148_1_inst0:GuiClipScale3Image;
      
      public var friend_list_bg:GuiClipScale9Image;
      
      public var layout_friends:ClipLayout;
      
      public var sideBGLight_inst0:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public function FriendsDailyGiftPopupClip()
      {
         button_invite = new ClipButtonLabeled();
         button_send_gifts = new FriendsDailyGiftSendButton();
         button_shop = new ClipButtonLabeled();
         button_invite_alt = new ClipButtonLabeled();
         layout_bottom_btns = ClipLayout.horizontalCentered(4,button_shop,button_invite);
         tf_caption = new ClipLabel();
         tf_caption_2 = new ClipLabel();
         tf_no_friends = new ClipLabel();
         panel_1 = new FriendRendererClip();
         panel_2 = new FriendRendererClip();
         panel_3 = new FriendRendererClip();
         panel_4 = new FriendRendererClip();
         panel_5 = new FriendRendererClip();
         panel_6 = new FriendRendererClip();
         panels = new <FriendRendererClip>[panel_1,panel_2,panel_3,panel_4,panel_5,panel_6];
         LinePale_148_148_1_inst0 = new GuiClipScale3Image(148,1);
         friend_list_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_friends = ClipLayout.horizontalCentered(4,panel_1,panel_2,panel_3,panel_4,panel_5,panel_6);
         sideBGLight_inst0 = new ClipSprite();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
         super();
      }
   }
}
