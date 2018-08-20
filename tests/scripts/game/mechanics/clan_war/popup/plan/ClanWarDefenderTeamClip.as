package game.mechanics.clan_war.popup.plan
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class ClanWarDefenderTeamClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_defenders:ClipLabel;
      
      public var tf_label_position:ClipLabel;
      
      public var team:MiniHeroTeamRenderer;
      
      public var tf_label_empty_team:ClipLabel;
      
      public var team_layout:ClipLayout;
      
      public var button_edit:ClipButton;
      
      public var button_gather:ClipButtonLabeled;
      
      public function ClanWarDefenderTeamClip()
      {
         tf_label_defenders = new ClipLabel();
         tf_label_position = new ClipLabel();
         team = new MiniHeroTeamRenderer();
         tf_label_empty_team = new ClipLabel();
         team_layout = ClipLayout.horizontalMiddleCentered(4,team);
         button_edit = new ClipButton();
         button_gather = new ClipButtonLabeled();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         super.setNode(param1);
         var _loc2_:int = team.hero.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            team_layout.addChild(team.hero[_loc3_].graphics);
            _loc3_++;
         }
         button_gather.label = Translate.translate("UI_CLAN_WAR_START_VIEW_GATHER");
      }
   }
}
