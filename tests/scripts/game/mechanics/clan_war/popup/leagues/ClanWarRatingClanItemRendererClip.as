package game.mechanics.clan_war.popup.leagues
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mechanics.clan_war.model.ClanWarRaitingClanData;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanWarRatingClanItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var place_tf:ClipLabel;
      
      public var name_tf:ClipLabel;
      
      public var points_tf:ClipLabel;
      
      public var icon_VP:ClipSprite;
      
      public var layout_vp:ClipLayout;
      
      public var up_icon:GuiClipImage;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var bg:GuiClipScale9Image;
      
      public function ClanWarRatingClanItemRendererClip()
      {
         place_tf = new ClipLabel();
         name_tf = new ClipLabel();
         points_tf = new ClipLabel(true);
         icon_VP = new ClipSprite();
         layout_vp = ClipLayout.horizontalMiddleCentered(3,points_tf,icon_VP);
         up_icon = new GuiClipImage();
         clan_icon = new ClanIconWithFrameClip();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function dispose() : void
      {
         if(clan_icon)
         {
            clan_icon.dispose();
         }
         graphics.dispose();
      }
      
      public function commitData(param1:ClanWarRaitingClanData, param2:int) : void
      {
         up_icon.graphics.visible = param2 + 1 <= param1.promoCount;
         place_tf.text = String(param2 + 1);
         if(param1.clanInfo)
         {
            name_tf.text = param1.clanInfo.title;
         }
         else
         {
            name_tf.text = Translate.translate("UI_COMMON_USR_NO_NAME");
         }
         points_tf.text = param1.points.toString();
         clan_icon.setData(param1.clanInfo);
      }
   }
}
