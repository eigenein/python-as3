package engine.loader
{
   import flash.text.TextField;
   
   public class SVNProps
   {
       
      
      public var URL:String;
      
      public var REVISION:String;
      
      public var DATE:String;
      
      public function SVNProps()
      {
         super();
      }
      
      public function get svnInfoString() : String
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         try
         {
            _loc3_ = URL.match(/https?:\/\/svn-local\.studionx\.ru\/heroes_client\/src_web\/([^\/]+)/)[1];
            _loc2_ = REVISION.match(/\$Revision: (\d+) \$/)[1];
            _loc1_ = DATE.match(/(\d+\-\d+-\d+ \d+:\d+:\d+)/)[1];
            var _loc5_:* = _loc3_ + " r" + _loc2_ + "@" + _loc1_;
            return _loc5_;
         }
         catch(error:Error)
         {
         }
         return "[no SVN info]";
      }
      
      public function get revision() : int
      {
         return REVISION.match(/\$Revision: (\d+) \$/)[1];
      }
      
      public function createTextField() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.text = svnInfoString;
         _loc1_.height = 25;
         _loc1_.width = 500;
         return _loc1_;
      }
   }
}
