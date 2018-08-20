package game.view.popup.arena.log
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.hero.MiniHeroPortraitClip;
   
   public class ArenaLogEntryPopupTeamItem extends GuiClipNestedContainer
   {
       
      
      public var tf_level:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var hero:MiniHeroPortraitClip;
      
      public function ArenaLogEntryPopupTeamItem()
      {
         tf_level = new ClipLabel();
         tf_name = new ClipLabel();
         hero = new MiniHeroPortraitClip();
         super();
      }
      
      public function set data(param1:UnitEntryValueObject) : void
      {
         graphics.visible = param1;
         if(param1)
         {
            tf_name.text = param1.name;
            tf_level.text = Translate.translateArgs("UI_COMMON_LEVEL",param1.level);
            hero.graphics.touchable = false;
            hero.data = param1;
         }
      }
   }
}
