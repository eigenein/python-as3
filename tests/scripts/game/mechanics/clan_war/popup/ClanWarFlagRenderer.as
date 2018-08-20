package game.mechanics.clan_war.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.HorizontalLayout;
   import game.battle.gui.BattleUserPanelBackground;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanWarFlagRenderer extends GuiClipNestedContainer
   {
       
      
      private var right:Boolean;
      
      public var tf_name:ClipLabel;
      
      public var tf_points:SpecialClipLabel;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var clan_icon_bg:ClipSpriteUntouchable;
      
      public var bg:BattleUserPanelBackground;
      
      public var button_list:ClipButton;
      
      public var icon_VP:ClipSprite;
      
      public var layout_points:ClipLayout;
      
      public var layout_title:ClipLayout;
      
      public function ClanWarFlagRenderer(param1:Boolean)
      {
         tf_name = new ClipLabel(true);
         tf_points = new SpecialClipLabel(true);
         clan_icon = new ClanIconWithFrameClip();
         clan_icon_bg = new ClipSpriteUntouchable();
         bg = new BattleUserPanelBackground();
         button_list = new ClipButton();
         icon_VP = new ClipSprite();
         layout_points = ClipLayout.horizontalMiddleCentered(2);
         layout_title = ClipLayout.horizontalMiddleCentered(5);
         super();
         bg.bg_clan.graphics.visible = false;
         this.right = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function setData(param1:ClanWarParticipantValueObject) : void
      {
         tf_name.text = param1.info.title;
         clan_icon.setData(param1.info);
         tf_points.text = String(param1.pointsEarned);
         var _loc2_:HorizontalLayout = layout_points.layout as HorizontalLayout;
         _loc2_.horizontalAlign = !!right?"left":"right";
         layout_points.removeChildren();
         _loc2_ = layout_title.layout as HorizontalLayout;
         _loc2_.horizontalAlign = !!right?"left":"right";
         layout_title.removeChildren();
         if(right)
         {
            layout_points.addChild(icon_VP.graphics);
            layout_points.addChild(tf_points);
            layout_title.addChild(tf_name);
            layout_title.addChild(button_list.graphics);
         }
         else
         {
            layout_points.addChild(tf_points);
            layout_points.addChild(icon_VP.graphics);
            layout_title.addChild(button_list.graphics);
            layout_title.addChild(tf_name);
         }
      }
   }
}
