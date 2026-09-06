package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.ResponseMessage;
import com.example.demo.service.DemoService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
public class DemoController {
  private final DemoService demoService;

  @GetMapping("/demo")
  public ResponseMessage getDemo() throws Exception {
    log.info("demo endpoint called");
    return new ResponseMessage(demoService.greeting());
  }
}
