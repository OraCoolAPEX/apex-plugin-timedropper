procedure render_timedropper (
  p_item   in            apex_plugin.t_item,
  p_plugin in            apex_plugin.t_plugin,
  p_param  in            apex_plugin.t_item_render_param,
  p_result in out nocopy apex_plugin.t_item_render_result )
is
  l_logging              boolean;
  l_autoswitch           boolean;
  l_meridians            boolean;
  l_format               varchar2(7);
  l_mousewheel           boolean;
  l_init_animation       varchar2(8);
  l_set_current_time     boolean;
  l_primary_color        varchar2(7);
  l_text_color           varchar2(7);
  l_background_color     varchar2(7);
  l_border_color         varchar2(7);
  l_theme                varchar2(10);
  l_html                 varchar2(4000);
  --
  --Convert Yes/No To True/False BOOLEAN Type
  --
  function yn_to_tf ( p_yn  in varchar2 )
  return boolean
  is
  begin
    case when lower(p_yn) = 'y' then return true;
    else return false;
    end case;
  end yn_to_tf;
begin
  --
  --Component-Level Custom Attributes
  --
  l_set_current_time  := yn_to_tf(p_item.attribute_01);
  --
  --Application-Level Custom Attributes
  --
  l_autoswitch        := yn_to_tf(p_plugin.attribute_01);
  l_meridians         := yn_to_tf(p_plugin.attribute_02);
  l_format            := sys.htf.escape_sc(p_plugin.attribute_03);
  l_mousewheel        := yn_to_tf(p_plugin.attribute_04);
  l_init_animation    := sys.htf.escape_sc(p_plugin.attribute_05);
  l_theme             := p_plugin.attribute_06;
  --
  --Add Theme CSS Files
  --
  case l_theme
    when 'vita_dark' then
      l_primary_color     := '#e6e6e6';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#262629';
    when 'vita_red' then
      l_primary_color     := '#da1b1b';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#c31818';
    when 'vita_slate' then
      l_primary_color     := '#505f6d';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#45525e';
    else
      l_primary_color     := '#0572ce';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#0465b5';
  end case;
  --
  --Debug Mode
  --
  if apex_application.g_debug then
    apex_plugin_util.debug_page_item (
      p_plugin              => p_plugin,
      p_page_item           => p_item,
      p_value               => p_param.value,
      p_is_readonly         => p_param.is_readonly,
      p_is_printer_friendly => p_param.is_printer_friendly );
  end if;
  --
  --Printer Friendly Display
  --
  if p_param.is_printer_friendly then
    apex_plugin_util.print_display_only (
      p_item_name           => p_item.name,
      p_display_value       => p_param.value,
      p_show_line_breaks    => false,
      p_escape              => true,
      p_attributes          => p_item.element_attributes );

    p_result.is_navigable := false;
  --
  --Read Only Display
  --
  elsif p_param.is_readonly then
    apex_plugin_util.print_hidden_if_readonly (
      p_item_name           => p_item.name,
      p_value               => p_param.value,
      p_is_readonly         => p_param.is_readonly,
      p_is_printer_friendly => p_param.is_printer_friendly );

    p_result.is_navigable := false;
  else
    l_html := '<input type="text" id="' || p_item.name || '" name="' || p_item.name || '" class="apex-item-text" />';

    sys.htp.p(l_html);

    --
    --Logging
    --
    if apex_application.g_debug then
      l_logging := true;
    else
      l_logging := false;
    end if;

    apex_javascript.add_onload_code (
      p_code => 'apexTimeDropper.initTimeDropper(' ||
                   apex_javascript.add_value (
                       p_value     => p_item.name,
                       p_add_comma => true )      || '{' ||
                   apex_javascript.add_attribute (
                       p_name      => 'autoswitch',
                       p_value     => l_autoswitch,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'meridians',
                       p_value     => l_meridians,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'format',
                       p_value     => l_format,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'mousewheel',
                       p_value     => l_mousewheel,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'initAnimation',
                       p_value     => l_init_animation,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'setCurrentTime',
                       p_value     => l_set_current_time,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'primaryColor',
                       p_value     => l_primary_color,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'textColor',
                       p_value     => l_text_color,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'backgroundColor',
                       p_value     => l_background_color,
                       p_add_comma => true )       ||
                   apex_javascript.add_attribute (
                       p_name      => 'borderColor',
                       p_value     => l_border_color,
                       p_add_comma => false )      || '},' ||
                   apex_javascript.add_value (
                       p_value     => l_logging,
                       p_add_comma => false ) || ');' );

    p_result.is_navigable := true;
  end if;
exception
  when others then
    raise;
end render_timedropper;