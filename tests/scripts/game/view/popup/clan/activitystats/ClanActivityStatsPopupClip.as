package game.view.popup.clan.activitystats
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   
   public class ClanActivityStatsPopupClip extends PopupClipBase
   {
       
      
      public var layout_tabs:ClipLayout;
      
      public var stats_content:ClanActivityStatsContentClip;
      
      public var send_gift_content:ClanActivityStatsSendGiftsContentClip;
      
      public function ClanActivityStatsPopupClip()
      {
         layout_tabs = ClipLayout.vertical(-16);
         stats_content = new ClanActivityStatsContentClip();
         send_gift_content = new ClanActivityStatsSendGiftsContentClip();
         super();
      }
   }
}
