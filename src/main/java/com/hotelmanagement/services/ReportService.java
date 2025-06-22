package com.hotelmanagement.services;

import java.io.ByteArrayOutputStream;

public interface ReportService {
    ByteArrayOutputStream generateExcelReport();
    ByteArrayOutputStream generatePDFReport();
} 