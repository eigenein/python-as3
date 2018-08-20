package game.mechanics.titan_arena.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.view.gui.components.DataClipButton;
   import game.view.popup.arena.PlayerPortraitClip;
   import starling.core.Starling;
   import starling.filters.ColorMatrixFilter;
   
   public class TitanArenaEnemyClip extends DataClipButton
   {
       
      
      public var island_clip:ClipSprite;
      
      public var player_portrait:PlayerPortraitClip;
      
      public var broken_icon:ClipSprite;
      
      public var dark_glow:ClipSprite;
      
      public var base:ClipSprite;
      
      public var bg_clan:ClipSprite;
      
      public var panel_user_name_bg_right_inst0:ClipSprite;
      
      public var points_block:TitanArenaEnemyClipPointsBlock;
      
      public var label:TitanArenaEnemyClipLabel;
      
      public var gemstone_array:TitanArenaEnemyClipGemstoneArray;
      
      private var _data:PlayerTitanArenaEnemy;
      
      public function TitanArenaEnemyClip()
      {
         island_clip = new ClipSprite();
         player_portrait = new PlayerPortraitClip();
         broken_icon = new ClipSprite();
         dark_glow = new ClipSprite();
         base = new ClipSprite();
         bg_clan = new ClipSprite();
         panel_user_name_bg_right_inst0 = new ClipSprite();
         points_block = new TitanArenaEnemyClipPointsBlock();
         label = new TitanArenaEnemyClipLabel();
         gemstone_array = new TitanArenaEnemyClipGemstoneArray();
         super(PlayerTitanArenaEnemy);
      }
      
      public function get data() : PlayerTitanArenaEnemy
      {
         return _data;
      }
      
      public function set data(param1:PlayerTitanArenaEnemy) : void
      {
         if(_data)
         {
            _data.property_points.signal_update.remove(handler_pointsUpdate);
         }
         if(param1 && !_data)
         {
            graphics.alpha = 0;
            Starling.juggler.tween(graphics,0.3,{
               "alpha":1,
               "transition":"easeOut"
            });
         }
         _data = param1;
         graphics.visible = _data != null;
         if(_data)
         {
            _data.property_points.signal_update.add(handler_pointsUpdate);
            updatePoints();
            label.tf_header.text = _data.nickname;
            label.tf_power.text = _data.power.toString();
            player_portrait.setData(_data);
         }
         else
         {
            player_portrait.setData(null);
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = param1 == "hover";
         if(isInHover != _loc3_)
         {
            isInHover = _loc3_;
            if(isInHover)
            {
               if(true || !hoverFilter)
               {
                  if(hoverFilter)
                  {
                     hoverFilter.dispose();
                  }
                  hoverFilter = new ColorMatrixFilter();
                  if(data && data.defeated)
                  {
                     hoverFilter.adjustBrightness(0.3);
                  }
                  else
                  {
                     hoverFilter.adjustBrightness(0.1);
                  }
               }
               if(island_clip.graphics.filter != hoverFilter)
               {
                  if(defaultFilter != island_clip.graphics.filter)
                  {
                     if(defaultFilter)
                     {
                        defaultFilter.dispose();
                     }
                     defaultFilter = _container.filter;
                  }
                  island_clip.graphics.filter = hoverFilter;
               }
            }
            else
            {
               island_clip.graphics.filter = defaultFilter;
            }
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         points_block.graphics.visible = false;
      }
      
      override protected function getClickData() : *
      {
         return _data;
      }
      
      private function updatePoints() : void
      {
         var _loc1_:* = null;
         player_portrait.graphics.alpha = !!_data.defeated?0.6:1;
         broken_icon.graphics.visible = _data.defeated;
         dark_glow.graphics.alpha = !!_data.defeated?1:0;
         points_block.graphics.visible = _data.property_points.value > 0;
         points_block.tf_points.text = _data.property_points.value.toString();
         gemstone_array.setTeam(_data.getTeam(0),_data.defeated);
         if(_data.defeated)
         {
            if(!island_clip.graphics.filter)
            {
               if(defaultFilter)
               {
                  defaultFilter.dispose();
               }
               _loc1_ = new ColorMatrixFilter();
               _loc1_.adjustSaturation(-0.3);
               _loc1_.adjustContrast(-0.4);
               _loc1_.adjustBrightness(0.2);
               defaultFilter = _loc1_;
               island_clip.graphics.filter = _loc1_;
               gemstone_array.graphics.filter = new ColorMatrixFilter(_loc1_.matrix);
               player_portrait.graphics.filter = new ColorMatrixFilter(_loc1_.matrix);
            }
         }
         else
         {
            if(island_clip.graphics.filter)
            {
               island_clip.graphics.filter.dispose();
               island_clip.graphics.filter = null;
            }
            if(gemstone_array.graphics.filter)
            {
               gemstone_array.graphics.filter.dispose();
               gemstone_array.graphics.filter = null;
            }
            if(player_portrait.graphics.filter)
            {
               player_portrait.graphics.filter.dispose();
               player_portrait.graphics.filter = null;
            }
         }
      }
      
      private function handler_pointsUpdate(param1:int) : void
      {
         updatePoints();
      }
   }
}
