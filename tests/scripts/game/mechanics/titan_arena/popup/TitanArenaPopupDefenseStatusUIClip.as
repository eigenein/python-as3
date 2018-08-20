package game.mechanics.titan_arena.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class TitanArenaPopupDefenseStatusUIClip extends GuiClipNestedContainer
   {
       
      
      public var button_defense:ClipButtonLabeled;
      
      public var tf_label_status:ClipLabel;
      
      public var tf_label_defenders:ClipLabel;
      
      public var team:MiniHeroTeamRenderer;
      
      public var lock_icon:ClipSprite;
      
      public var team_layout:ClipLayout;
      
      public var tf_label_gather_defense:ClipLabel;
      
      public var button_set_defense:ClipButtonLabeled;
      
      public var team_container_layout:ClipLayout;
      
      public function TitanArenaPopupDefenseStatusUIClip()
      {
         button_defense = new ClipButtonLabeled();
         tf_label_status = new ClipLabel();
         tf_label_defenders = new ClipLabel();
         team = new MiniHeroTeamRenderer();
         lock_icon = new ClipSprite();
         team_layout = ClipLayout.horizontalMiddleCentered(4,team);
         tf_label_gather_defense = new ClipLabel();
         button_set_defense = new ClipButtonLabeled();
         team_container_layout = ClipLayout.none(tf_label_defenders,team_layout,button_defense,lock_icon);
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
      }
   }
}
