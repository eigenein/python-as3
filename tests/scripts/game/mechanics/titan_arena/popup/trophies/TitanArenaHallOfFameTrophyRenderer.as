package game.mechanics.titan_arena.popup.trophies
{
   import game.assets.storage.AssetStorage;
   import game.model.user.hero.PlayerTitanArenaTrophyData;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class TitanArenaHallOfFameTrophyRenderer extends ListItemRenderer
   {
       
      
      protected var clip:TitanArenaHallOfFameTrophyRendererClip;
      
      public function TitanArenaHallOfFameTrophyRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(clip)
         {
            clip.dispose();
         }
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         clip.commitData(data as PlayerTitanArenaTrophyData);
         addChild(clip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaHallOfFameTrophyRendererClip,"titan_arena_trophy_renderer");
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
   }
}
